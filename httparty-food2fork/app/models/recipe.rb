class Recipe
  include HTTParty

  default_options.update(verify: false)
  @key_value = ENV['FOOD2FORK_KEY']
  hostport = ENV['FOOD2FORK_SERVER_AND_PORT'] || 'www.food2fork.com'
  base_uri "http://#{hostport}/api/search"
  default_params key: @key_value
  format :json

  def self.for keyword
    res = get("", query: { q: keyword })['recipes']
  end

end
