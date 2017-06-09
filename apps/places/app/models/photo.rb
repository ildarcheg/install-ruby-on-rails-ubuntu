require 'mongo'
require 'json'
require 'pp'
require 'byebug'
require 'exifr'


Mongo::Logger.logger.level = ::Logger::INFO

class Photo

  attr_accessor :id, :location
  attr_writer :contents

  MONGO_URL='mongodb://localhost:27017'
  MONGO_DATABASE='test'
  PLACE_COLLECTION='places'

  def initialize(params=nil)
    #@id=params[:_id].nil? ? params[:id] : params[:_id].to_s

    if !params.nil? then
      photo_hash = params.symbolize_keys
      @id = photo_hash[:_id].nil? ? photo_hash[:id] : photo_hash[:_id].to_s
      location_from_hash = photo_hash[:metadata].nil? ? nil : photo_hash[:metadata][:location]
      if !location_from_hash.nil? then
        @location = Point.new(location_from_hash.symbolize_keys)
      end
      place_from_hash = photo_hash[:metadata].nil? ? nil : photo_hash[:metadata][:place]
      if !place_from_hash.nil? then
        @place = place_from_hash
      end
    end
  end

  def persisted?
    return !@id.nil?
  end

  def place
    if !@place.nil?
      Place.find(@place.to_s)
    end
  end  
 
  def place=(place)
   if place.is_a? String
     @place=BSON::ObjectId.from_string(place)
   else 
     @place=place
   end
  end

  def save
    @place = BSON::ObjectId.from_string(@place.id) if @place.is_a? Place

    if !self.persisted? && @contents then
      gps = EXIFR::JPEG.new(@contents).gps
      @location=Point.new(:lng=>gps.longitude, :lat=>gps.latitude)
      @contents.rewind
      description={}
      description[:metadata] = {
        :location => @location.to_hash
      }
      description[:content_type] = "image/jpeg"

      grid_file = Mongo::Grid::File.new(@contents.read, description)
      @id = self.class.mongo_client.database.fs.insert_one(grid_file).to_s
    else
      #doc = self.class.mongo_client.database.fs.find('_id': BSON::ObjectId.from_string(@id)).first
      file_cursor = self.class.mongo_client.database.fs.find('_id': BSON::ObjectId.from_string(@id))
      doc = file_cursor.first
      doc[:metadata][:location] = @location.to_hash
      doc[:metadata][:place] = @place
      #self.class.mongo_client.database.fs.find('_id': BSON::ObjectId.from_string(@id)).update_one(doc)
      file_cursor.update_one(doc)
    end 

  end

  def contents
    f = self.class.mongo_client.database.fs.find_one(:_id=>BSON::ObjectId.from_string(@id))
    if f 
      buffer = ""
      f.chunks.reduce([]) do |x,chunk| 
          buffer << chunk.data.data 
      end
      return buffer
    else
      return nil
    end 
  end

  def destroy
    self.class.mongo_client.database.fs.find(:_id=>BSON::ObjectId.from_string(@id)).delete_one
  end

  def find_nearest_place_id max_meters
    nearest_places = Place.to_places(Place.near(@location, max_meters))
    return nearest_places.count == 0 ? 0 : BSON::ObjectId.from_string(nearest_places[0].id)
  end

  def self.find file_id
    doc = mongo_client.database.fs.find(:_id => BSON::ObjectId(file_id)).first
    return doc.nil? ? nil : Photo.new(doc)
  end


  def self.mongo_client
    Mongoid::Clients.default
  end

  def self.all(offset=0, limit=nil)
    results = mongo_client.database.fs.find()
    results = results.skip(offset)
    results = results.limit(limit) if !limit.nil?
    array = results.map {|f| pp Photo.new(f)}
    return array
  end 

  def self.find_photos_for_place place_id
    place_id_to_find = place_id.is_a?(String) ? BSON::ObjectId.from_string(place_id) : place_id
    puts place_id_to_find
    mongo_client.database.fs.find("metadata.place": place_id_to_find) 
  end

end