require 'mongo'
require 'json'
require 'pp'
require 'byebug'


Mongo::Logger.logger.level = ::Logger::INFO

class Place
  include ActiveModel::Model

  attr_accessor :id, :formatted_address, :location, :address_components 

  MONGO_URL='mongodb://localhost:27017'
  MONGO_DATABASE='test'
  PLACE_COLLECTION='places'

  def persisted?
    !@id.nil?
  end

  def initialize(params)
    @address_components = []
    @id=params[:_id].nil? ? params[:id] : params[:_id].to_s
    @formatted_address=params[:formatted_address]
    @location = Point.new(params[:geometry][:geolocation])
    if !params[:address_components].nil? then
      params[:address_components].each { |component| @address_components << AddressComponent.new(component) }
    end
  end

  def destroy
    self.class.collection.find(_id: BSON::ObjectId(@id)).delete_one
  end

  def near (max_meters=nil)
    near_docs = self.class.near(@location, max_meters)
    return near_docs.map {|doc| Place.new(doc)}
  end

  def photos (offset=0, limit=nil)
    results = Photo.find_photos_for_place(@id)
    results = results.skip(offset)
    results = results.limit(limit) if !limit.nil?
    return results.map {|r| Photo.new(r)}
  end

  def self.mongo_client
    Mongoid::Clients.default
  end

  def self.collection
    collection=ENV['PLACE_COLLECTION'] ||= PLACE_COLLECTION
    return mongo_client[collection]
  end
  
  # helper method that will load a file and return a parsed JSON document as a hash
  # use Place.load_all(File.open('./db/places.json'))
  def self.load_all(file_path) 
    file=File.read(file_path)
    places_hash = JSON.parse(file)
    self.collection.insert_many(places_hash)
  end

  def self.find_by_short_name(short_name)
    collection.find('address_components.short_name': short_name)
  end

  def self.to_places(params)
    places = []
    params.each { |value| places << Place.new(value) }
    return places
  end

  def self.find id
    result=collection.find(:_id=>BSON::ObjectId(id)).first
    return result.nil? ? nil : Place.new(result)
  end

  def self.all(offset=nil, limit=nil)
    results = self.collection.find()
    results = results.skip(offset) if !offset.nil?
    results = results.limit(limit) if !limit.nil?
    results = to_places(results)
    return results
  end

  def self.get_address_components(sort=nil, offset=nil, limit=nil)

    pipeline = []
    pipeline << {:$project => {:_id => 1, :address_components => 1, :formatted_address => 1, 'geometry.geolocation' => 1} }
    pipeline << {:$unwind => '$address_components'}
    if sort then pipeline << {:$sort => sort} end
    if offset then pipeline << {:$skip => offset} end
    if limit then pipeline << {:$limit => limit} end 

    return collection.find.aggregate(pipeline)

  end

  def self.get_country_names
    pipeline = []
    pipeline << {:$project => {:_id => 0, 'address_components.long_name' => 1, 'address_components.types' => 1} }
    pipeline << {:$unwind => '$address_components'}
    pipeline << {:$match => {'address_components.types' => 'country'}}
    pipeline << {:$group => {:_id => {:long_name => '$address_components.long_name'} } }

    #result = collection.find.aggregate(pipeline).to_a.map {|h| h[:_id]; puts h[:_id]}
    #return result

    return collection.find.aggregate(pipeline).to_a.map {|h| h[:_id][:long_name]}
  end

  def self.find_ids_by_country_code country_code
   
    pipeline = []
    pipeline << {:$project => {:_id => 1, 'address_components.short_name' => 1, 'address_components.types' => 1} }
    pipeline << {:$unwind => '$address_components'}
    pipeline << {:$match => {'address_components.types' => 'country', 'address_components.short_name' => country_code}}
    pipeline << {:$group => {:_id => {:_id => '$_id'} } }

    #result = collection.find.aggregate(pipeline).to_a.map {|h| h[:_id]; puts h[:_id]}
    #return result

    return collection.find.aggregate(pipeline).to_a.map {|h| pp h[:_id][:_id].to_s}

  end

  def self.create_indexes
    collection.indexes.create_one('geometry.geolocation' => Mongo::Index::GEO2DSPHERE)
  end

  def self.remove_indexes
    collection.indexes.drop_one("geometry.geolocation_2dsphere")
  end

  def self.near (point, max_meters=nil)
    near_hash = {:$geometry => point.to_hash}
    if !max_meters.nil? then near_hash[:$maxDistance] = max_meters end
    collection.find('geometry.geolocation' => {:$near => near_hash} )
  end

end