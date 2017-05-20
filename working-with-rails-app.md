# Working with Rails App

Create new Rails app
```
rails new my_first_app
```

Create Git repo
```
cd my_first_app
git init
git add .
git commit -m "Initial commit"
```

Run Rails app
```
rails server
```


Generate a controller (named 'greeter' wirh action 'hello'), use 'g' for 'generate'
rails generate controller greeter hello  

```
create  app/controllers/greeter_controller.rb
route  get 'greeter/hello'
invoke  erb
create    app/views/greeter
create    app/views/greeter/hello.html.erb
invoke  test_unit
create    test/controllers/greeter_controller_test.rb
invoke  helper
create    app/helpers/greeter_helper.rb
invoke    test_unit
invoke  assets
invoke    coffee
create      app/assets/javascripts/greeter.coffee
invoke    scss
create      app/assets/stylesheets/greeter.scss
```

Routes in config/routes.rb
```ruby
get 'courses/index'
get 'greeter/hello' => "greeter#hello"
get 'greeter/goodbye'
root 'courses#index'
```

Rake
```
rake --tasks
rake --describe routes
rake routes
```

Gemfile
```ruby
gem 'httparty', '0.13.5'
```
run 'bundle' in app folder after changing Gemfile

HTTParty 
```ruby
require 'httparty'
require 'pp'

class Recipe
	include HTTParty
	base_uri 'http://food2fork.com/api'
	default_params key: "35266a74b902afca9b63150995cdcd0e"
	format :json
	def self.for term
		get("/search",query: {q: term})["recipes"]
	end
end

pp Recipe.for "chocolate"
```

Heroku install
```
sudo add-apt-repository "deb https://cli-assets.heroku.com/branches/stable/apt ./"
curl -L https://cli-assets.heroku.com/apt/release.key | sudo apt-key add -
sudo apt-get update
sudo apt-get install heroku
heroku --version
```

Heroku create app
```
cd ~/your_app_folder
heroku login
heroku create your_app_name
git push heroku master
heroku config:set FOOD2FORK_KEY=<"35266a74b902afca9b63150995cdcd0e"
```

Working with ActiveRecord. Add table to DB using scaffold
```
rails new fancy_car
cd fancy_car
rails g scaffold car make color year:integer
rake db:migrate
```

orking with ActiveRecord. Add table to DB using model
```
rails new fancy_car
cd fancy_car
rails g model car make color year:integer
rake db:migrate
```

Working with ActiveRecord. Changing tables (add columns)
```
cd fancy_car
rails g migration add_price_to_cars 'price:decimal{10,2}'
rake db:migrate
```

Working with ActiveRecord. Changing tables (rename columns)
```
cd fancy_car
rails g migration rename_make_to_company
rake db:migrate
```

Working with ActiveRecord. SQLite
```
sudo apt-get install sqlite3
cd fancy_car
rails db
.help
.tables
.headers on
.mode columns
select * from cars;
.exit
```

Working with ActiveRecord. SQLite - create rows and retrive rows
```
sudo apt-get install sqlite3
cd fancy_car
rails c
p1 = Person.new; p1.first_name = "Joe"; p1.last_name = "Fox"; p1.save
p2 = Person.new(first_name: "Joe", last_name: "Fox"); p2.save # should be hash
p3 = Person.create(first_name: "Joe", last_name: "Fox") # shoud be hash

person_joe = Person.find(0)
person_all = Person.all #not an Array
person_first = Person.all.order(first_name: :desc).to_a

person_random = Person.take
person_two_random = Person.take 2

person_names = Person.all.map { |person| person.first_name} #gets all records and only one column from it
person_names = Person.pluck(:first_name) #gets only one column

persons_with_name_joe = Person.where(last_name: "Doe")
persons_with_name_joe = Person.where(last_name: "Doe").first # performs as Limit 1
persons_with_name_joe = Person.where(last_name: "Doe")[0] # performs as ALL and select only one record

person_joe = Person.find_by(last_name: "Doe") # gets only one record or nil
person_joe = Person.find_by!(last_name: "Doe") # gets only one record or exeption

person_count = Person.count
person_not_from_begining = Person.offset(1).limit(1) # skip some records and get 1
```

Working with ActiveRecord. SQLite - update rows and delete rows
```
sudo apt-get install sqlite3
cd fancy_car
rails c
person_max = Person.find_by(first_name: "Max"); person_max.last_name="Bush"; person_max.save
person_max = Person.find_by(first_name: "Max").update(last_name: "Clinton")
```

SQLite browser
```
sudo add-apt-repository -y ppa:linuxgndu/sqlitebrowser
sudo apt-get update
sudo apt-get install sqlitebrowser
```

Time zone
```ruby
 config.time_zone='Hanoi'
 config.active_record.default_timezone=:local
```
