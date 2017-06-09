class Point

	attr_accessor :longitude, :latitude

	def initialize (hash_point)
		
		if hash_point[:type] == 'Point' && 
			hash_point[:coordinates].is_a?(Array) && 
			hash_point[:coordinates].count == 2 then

			@latitude = hash_point[:coordinates][1]
			@longitude = hash_point[:coordinates][0]

  	elsif hash_point[:lat] && hash_point[:lng] then

			@latitude = hash_point[:lat]
			@longitude = hash_point[:lng]

		else
			message = "Point format shoulb be:\n{'type':'Point', 'coordinates':[ -1.8625303, 53.8256035]}\nor\n{'lat':53.8256035, 'lng':-1.8625303}"
			raise Exception.new(message)
  	end
	end

	def to_hash
		{type: 'Point', coordinates: [@longitude, @latitude]}
	end
end