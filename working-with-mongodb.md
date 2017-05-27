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

