# Working with MongoDB

### Install MongoDB
Download and install following instructions https://www.mongodb.com/download-center#community

### Shell Quick Reference
Use mongo shell https://docs.mongodb.com/manual/reference/mongo-shell/

### Download sample data
Use link to download data  
```
curl -O http://media.mongodb.org/zips.json
```

### Create database and upload data
Create 'test' database and updato sample data to 'zips' collection  
```
mongoimport --db test --collection zips --drop --file ~/Downloads/zips.json
mongoimport --db test --collection zips --drop --file ~/Downloads/zips.json --jsonArray # for array
```

### Install required Gems
Install following gems 
```
gem update -system
gem install mongo
gem install bson_ext
```
Use gem 
```ruby
require mongo
```

### Use MongoDB in 'irb'
USe following basic commands
```
irb
```

```ruby
require 'mongo'
db = Mongo::Client.new('mongodb://localhost:27017')
db = db.use('test')
db.database.name # shows db name 'test'
db.database.collection_names # shows collection names inside db 'test'
db[:zips].find.first # returns first entry in 'zips' collection 'test' db
```

```ruby
system('clear') # clear screen
```

```ruby
Mongo::Logger.logger.level = ::Logger::INFO # turn debugger off
Mongo::Logger.logger.level = ::Logger::DEBUG # turn debugger on
```

### Sample Ruby class to work with MongoDB
USe following code
```ruby
require 'pp'
require 'mongo'

class Solution
  @@db = nil
  
  #Implement a class method in the `Solution` class called `mongo_client` that will 
  def self.mongo_client
    #create a `Mongo::Client` connection to the server using a URL (.e.g., 'mongodb://localhost:27017')
    #configure the client to use the `test` database
    #assign the client to @@db class variable and return that client
    @@db1 = Mongo::Client.new('mongodb://localhost:27017')
		@@db1 = @@db1.use('test')
  end

  #Implement a class method in the `Solution` class called `collection` that will
  def self.collection
    #return the `zips` collection
    @@db1[:zips]
  end

  #Implement an instance method in the `Solution` class called `sample` that will
  def sample
    #return a single document from the `zips` collection from the database. 
    #This does not have to be random. It can be first, last, or any other document in the collection.
    self.class.collection.find.first
  end
end

#byebug
db=Solution.mongo_client
p db
zips=Solution.collection
p zips
s=Solution.new
pp s.sample
```

### Sample Ruby class to work with MongoDB
USe following code
```ruby
db[:zips].insert_one(:_id => "100", :city => "city01", :loc => [-76.05, 39.09], :pop => 4678, :state => "MD")
db[:zips].find(:city => 'city01').count
db[:zips].insert_many([
	{:_id => "100", :city => "city01", :loc => [-76.05, 39.09], :pop => 4678, :state => "MD"},
	{:_id => "101", :city => "city02", :loc => [-76.05, 39.09], :pop => 4678, :state => "MD"}
])
```

### One more sample Ruby class to work with MongoDB
USe following code
```ruby
require 'mongo'
require 'json'
require 'pp'
require 'byebug'
Mongo::Logger.logger.level = ::Logger::INFO
#Mongo::Logger.logger.level = ::Logger::DEBUG

class Solution
  MONGO_URL='mongodb://localhost:27017'
  MONGO_DATABASE='test'
  RACE_COLLECTION='race1'

  # helper function to obtain connection to server and set connection to use specific DB
  # set environment variables MONGO_URL and MONGO_DATABASE to alternate values if not
  # using the default.
  def self.mongo_client
    url=ENV['MONGO_URL'] ||= MONGO_URL
    database=ENV['MONGO_DATABASE'] ||= MONGO_DATABASE 
    db = Mongo::Client.new(url)
    @@db=db.use(database)
  end

  # helper method to obtain collection used to make race results. set environment
  # variable RACE_COLLECTION to alternate value if not using the default.
  def self.collection
    collection=ENV['RACE_COLLECTION'] ||= RACE_COLLECTION
    return mongo_client[collection]
  end
  
  # helper method that will load a file and return a parsed JSON document as a hash
  def self.load_hash(file_path) 
    file=File.read(file_path)
    JSON.parse(file)
  end

  # initialization method to get reference to the collection for instance methods to use
  def initialize
    @coll=self.class.collection
  end

  #
  # Lecture 1: Create
  #

  def clear_collection
    @coll.delete_many({})
  end

  def load_collection(file_path) 
    hash=self.class.load_hash(file_path)
    @coll.insert_many(hash)
  end

  def insert(race_result)
    @coll.insert_one(race_result)
  end

  #
  # Lecture 2: Find By Prototype
  #

  def all(prototype={})
    @coll.find(prototype)
  end

  def find_by_name(fname, lname)
    @coll.find(first_name: fname, last_name: lname).projection(first_name:1, last_name:1, number:1, _id:0)
  end

  #
  # Lecture 3: Paging
  #

  def find_group_results(group, offset, limit) 
    @coll.find(group:group)
         .projection(group:0, _id:0)
         .sort(secs:1).skip(offset).limit(limit)
  end

  #
  # Lecture 4: Find By Criteria
  #

  def find_between(min, max) 
    @coll.find(secs: {:$gt=>min, :$lt=>max} )
  end

  def find_by_letter(letter, offset, limit) 
    @coll.find(last_name: {:$regex=>"^#{letter.upcase}.+"})
         .sort(last_name:1)
         .skip(offset)
         .limit(limit)
  end

  #
  # Lecture 5: Updates
  #
  
  def update_racer(racer)
    @coll.find(_id: racer[:_id]).replace_one(racer)
  end

  def add_time(number, secs)
    @coll.find(number: number).update_one(:$inc => {:secs => secs})
  end

end

s=Solution.new
race1=Solution.collection
```

### Working with 'mongoid'
Add to Gemfile and run 'bundle'
```ruby
gem 'mongoid', '~> 5.0.0'
```
Setup mongoid
```
rails g mongoid:config
```

```
rails c
mongo_client = Mongoid::Clients.default
collection = mongo_client[:zips]
```

Clone sample app and look through
```
git clone https://github.com/jhu-ep-coursera/fullstack-course3-module1-zips.git
```
