#echo 'export FOOD2FORK_KEY = "Your API Key"' >> ~/.profile
#
require 'httparty'
require 'pp'

class Recipe
	include HTTParty
	base_uri 'http://food2fork.com/api'
	default_params key: "2e46a77fe69ee6628be6ca9f00517a4a"
	format :json
	def self.for term
		get("/search",query: {q: term})["recipes"]
	end
end

pp Recipe.for "chocolate"