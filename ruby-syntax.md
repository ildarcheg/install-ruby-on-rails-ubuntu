# Ruby syntax

Hash sample 1
```ruby
h = {'dog' => 'canine', 'cat' => 'feline', 'donkey' => 'asinine', 12 => 'dodecine'}  
puts h.length  # 4  
puts h['dog']  # 'canine'  
puts h  
puts h[12] 
```
output
```
4
canine
{"dog"=>"canine", "cat"=>"feline", "donkey"=>"asinine", 12=>"dodecine"}
dodecine
```

Hash sample 2
```ruby
people = Hash.new  
people[:nickname] = 'IndianGuru'  
people[:language] = 'Marathi'  
people[:lastname] = 'Talim' 

h = {:nickname => 'IndianGuru', :language => 'Marathi', :lastname => 'Talim'}  

h = {nickname: 'IndianGuru', language: 'Marathi', lastname: 'Talim'}  

hash = {1: 'one'} # will not work  
hash = {1 => 'one'} # will work
```

Range sample 1
```ruby
(1..10).to_a -> [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

digits = -1..9  
puts digits.include?(5)          # true  
puts digits.min                  # -1  
puts digits.max                  # 9  
puts digits.reject {|i| i < 5 }  # [5, 6, 7, 8, 9] 

(1..10) === 5       -> true  
(1..10) === 15      -> false  
(1..10) === 3.14159 -> true  
('a'..'j') === 'c'  -> true  
('a'..'j') === 'z'  -> false
```

Dynamic 1
```ruby
class Dog 
	def bark
		puts "Woof, Woof!"
	end

	def greet(greeting)
		puts greeting
	end
end

dog = Dog.new
dog.bark
dog.send("bark")
dog.send(:bark)
method_name = "greet"
dog.send(method_name, 'Hi friend')
```
 
 Dynamic 2
```ruby
class Person
	attr_accessor :name, :age
end

person = Person.new
props = { name: "John", age: 15}
props.each { |key, value| puts person.send("#{key}=", value)} 

person
```
