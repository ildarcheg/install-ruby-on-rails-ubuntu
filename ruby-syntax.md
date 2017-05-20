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

Hash sample 1
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
