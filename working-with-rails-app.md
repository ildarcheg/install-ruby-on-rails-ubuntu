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

Time zone
```ruby
 config.time_zone='Hanoi'
 config.active_record.default_timezone=:local
```

SQLite
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

SQLite browser
```
sudo add-apt-repository -y ppa:linuxgndu/sqlitebrowser
sudo apt-get update
sudo apt-get install sqlitebrowser
```
