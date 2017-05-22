# Working with Rails App

### Create new Rails app
Directory my_first_app will be created
```
rails new my_first_app
```


### Create Git repo
Initialize git repo once app is created
```
cd my_first_app
git init
git add .
git commit -m "Initial commit"
```


### Run Rails app
Start rails server in separate terminal session
```
rails server
```


### Generate a controller
Generate a controller (named 'greeter' wirh action 'hello'), use 'g' for 'generate'
```
rails g controller greeter hello 
```

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


### Routes
Check routes in config/routes.rb
```ruby
get 'courses/index'
get 'greeter/hello' => "greeter#hello"
get 'greeter/goodbye'
root 'courses#index'
```


### Rake
Use rake for what?
```
rake --tasks
rake --describe routes
rake routes
```


### Gemfile
Setup all required gems in Gemfile. Run 'bundle' in app folder after changing Gemfile
```ruby
gem 'httparty', '0.13.5'
```


### HTTParty 
Use HTTParty for http requetss
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


### Heroku. Install
Install Heroku using folowing code (get updated code on Heroku.com)
```
sudo add-apt-repository "deb https://cli-assets.heroku.com/branches/stable/apt ./"
curl -L https://cli-assets.heroku.com/apt/release.key | sudo apt-key add -
sudo apt-get update
sudo apt-get install heroku
heroku --version
```


### Heroku. Create app
Go to app folder, login and create heroku app using unique name
```
cd ~/your_app_folder
heroku login
heroku create your_app_name
git push heroku master
heroku config:set FOOD2FORK_KEY=<"35266a74b902afca9b63150995cdcd0e"
```


### ActiveRecord. Add table 1.
Add new table to DB using scaffold
```
rails new fancy_car
cd fancy_car
rails g scaffold car make color year:integer
rake db:migrate
```


### ActiveRecord. Add table 2.
Add table to DB using model
```
rails new fancy_car
cd fancy_car
rails g model car make color year:integer
rake db:migrate
```


### ActiveRecord. Changing tables
Add columns to table using migration
```
cd fancy_car
rails g migration add_price_to_cars 'price:decimal{10,2}'
rake db:migrate
```

```ruby
# db/migrate/20170520111336_add_price_to_cars.rb
class AddPriceToCars < ActiveRecord::Migration
  def change
    add_column :cars, :price, :decimal, precision: 10, scale: 2
  end
end
```


### ActiveRecord. Changing tables
Rename columns in table using migration
```
cd fancy_car
rails g migration rename_make_to_company
rake db:migrate
```

```ruby
# db/migrate/20170520112217_rename_make_to_company.rb
class RenameMakeToCompany < ActiveRecord::Migration
  def change
  	rename_column :cars, :make, :company
  end
end
```


### ActiveRecord. SQLite
Check databases and tables using 'rails db'
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


### ActiveRecord. SQLite create and retrive
Create and retrive records using following code
```
sudo apt-get install sqlite3
```

```
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


### ActiveRecord. SQLite update and delete
Update and delete records using following code
```
sudo apt-get install sqlite3
```

```
cd fancy_car
rails c
person_max = Person.find_by(first_name: "Max"); person_max.last_name="Bush"; person_max.save
person_max = Person.find_by(first_name: "Max").update(last_name: "Clinton")
```


### ActiveRecord. Seeding the Database 
Setup sample records for your database
```
rake db:seed
```

```
Job.destroy_all
Person.destroy_all

Person.create! [
  { first_name: "Kalman", last_name: "Smith", age: 33, login: "kman", pass: "abc123" },
  { first_name: "John", last_name: "Whatever", age: 27, login: "john1", pass: "123abc" },
  { first_name: "Michael", last_name: "Smith", age: 15, login: "mike", pass: "not_telling" },
  { first_name: "Josh", last_name: "Oreck", age: 57, login: "josh", pass: "password1" },
  { first_name: "John", last_name: "Smith", age: 27, login: "john2", pass: "no_idea" },
  { first_name: "Bill", last_name: "Gates", age: 75, login: "bill", pass: "windows3.1" },
  { first_name: "LeBron", last_name: "James", age: 30, login: "bron", pass: "need more rings" }
]

Person.find_by!(first_name: "Kalman").create_personal_info(height: 6.0, weight: 210)
Person.find_by!(first_name: "John", last_name: "Whatever").create_personal_info(height: 5.3, weight: 175)
Person.find_by!(first_name: "Michael").create_personal_info(height: 5.5, weight: 200)
Person.find_by!(first_name: "Josh").create_personal_info(height: 6.5, weight: 235)
Person.find_by!(first_name: "John", last_name: "Smith").create_personal_info(height: 6.0, weight: 210)
Person.find_by!(first_name: "Bill").create_personal_info(height: 6.1, weight: 199)
Person.find_by!(first_name: "LeBron").create_personal_info(height: 7.0, weight: 250)

Person.first.jobs.create! [
  { title: "Developer", company: "MS", position_id: "#1234" },
  { title: "Developer", company: "MS", position_id: "#1235" }
]

Person.last.jobs.create! [
  { title: "Sr. Developer", company: "MS", position_id: "#5234" },
  { title: "Sr. Developer", company: "MS", position_id: "#5235" }
]
```


### ActiveRecord. One-to-One 
```
rails g model personal_info height:float weight:float person:references
```

```ruby
# db/migrate/20150908232650_create_personal_infos.rb
class CreatePersonalInfos < ActiveRecord::Migration
  def change
    create_table :personal_infos do |t|
      t.float :height
      t.float :weight
      t.references :person, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
```

```ruby
# app/models/person.rb
class Person < ActiveRecord::Base
	has_one :personal_info, dependent: :destroy
end
```

```ruby
# app/models/personal_info.rb
class PersonalInfo < ActiveRecord::Base
  belongs_to :person
end
```

```ruby
bill = Person.find_by lats_name: "Gates"
bill.build_personal_info height: 6.0 weight: 180 # erase person_id in record in personal_info but do not add new person_record till saved
bill.save # add record in persona_info

bill.create_personal_info height: 5.0 weight: 170 # update record in personal_info but do not add new till saved
```


### ActiveRecord. One-to-Many 
```
rails g model job title company position_if person:references
```

```ruby
# db/migrate/20170521125626_create_jobs.rb
class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :title
      t.string :company
      t.string :position_id
      t.references :person, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
```

```ruby
# app/models/person.rb
class Person < ActiveRecord::Base
  has_many :jobs
  has_many :my_jobs, class_name: "Job"
end
```

```ruby
# app/models/job.rb
class Job < ActiveRecord::Base
  belongs_to :person
end
```

```ruby
Job.create company: "MS", title: "Developer", position_id: "#1234"
p1 = Person.first
p1.jobs << Job.first # will append
p1.jobs = list_of_person_jobs # will replace with a new array of jobs
```


### ActiveRecord. Many-to-Many 
```
rails g model hobby name
rake db:migrate
rails g migration create_hobbies_people person:references hobby:references
# do not run 'rake db:migrate' till update db/migrate/20170521133616_create_hobbies_people.rb with 'id: false'
```

```ruby
# db/migrate/20170521133616_create_hobbies_people.rb
class CreateHobbiesPeople < ActiveRecord::Migration
  def change
    create_table :hobbies_people, id: false do |t|
      t.references :person, index: true, foreign_key: true
      t.references :hobby, index: true, foreign_key: true
    end
  end
end
```

```ruby
# app/models/person.rb
class Person < ActiveRecord::Base
	has_and_belongs_to_many :hobbies
end

```

```ruby
# app/models/hobby.rb
class Hobby < ActiveRecord::Base
	has_and_belongs_to_many :people
end
```

```ruby
bill = Person.find_by first_name: "Bill"
nick = Person.find_by first_name: "Nick"
programming = Hobby.create name: "Programming"
bill.hobbies << programming; nick.hobbies << programming
```


### ActiveRecord. Many-to-Many through
```
rails g model salary_range min_salary:float max_salary:float job:references
rake db:migrate

rails g migration create_hobbies_people person:references hobby:references
# do not run 'rake db:migrate' till update db/migrate/20170521133616_create_hobbies_people.rb with 'id: false'
```

```ruby
# db/migrate/20170521141424_create_salary_ranges.rb
class CreateSalaryRanges < ActiveRecord::Migration
  def change
    create_table :salary_ranges do |t|
      t.float :min_salary
      t.float :max_salary
      t.references :job, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
```

```ruby
# app/models/job.rb
class Job < ActiveRecord::Base
  has_one :salary_range
end
```

```ruby
# app/models/salary_range.rb
class SalaryRange < ActiveRecord::Base
  belongs_to :job
end
```

```ruby
# app/models/person.rb
class Person < ActiveRecord::Base
  has_many :aprox_salaries, through: :jobs, source: :salary_range
  def max_salary
    aprox_salaries.maximum(:max_salary)
  end
end
```


```ruby
bill = Person.find_by first_name: "Bill"
nick = Person.find_by first_name: "Nick"
programming = Hobby.create name: "Programming"
bill.hobbies << programming; nick.hobbies << programming
```


### SQLite browser
Install sqlitebrowser for DB view 
```
sudo add-apt-repository -y ppa:linuxgndu/sqlitebrowser
sudo apt-get update
sudo apt-get install sqlitebrowser
```


### Time zone
Setup time zone
```ruby
 config.time_zone='Hanoi'
 config.active_record.default_timezone=:local
```
