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
