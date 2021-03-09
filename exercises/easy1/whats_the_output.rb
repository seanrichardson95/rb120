# Take a look at the following code?

class Pet
  attr_reader :name

  def initialize(name)
    @name = name.to_s
  end

  def to_s
    "My name is #{@name.upcase}."
  end
end

name = 42
fluffy = Pet.new(name)
name += 1
puts fluffy.name
puts fluffy
puts fluffy.name
puts name

# What's the output?

# My answer:
# Line 18 outputs Fluffy because

# Further Explanation:
# On line 16, 42 is passed to Pet.new, and @name is initialized to 42.to_s, which is "42".
# On line 18, fluffy.name, which points to 42, is passed as an argument to puts, thus 42 is output to the terminal.
# On line 19, fluffy is passed to the puts method. Since the method to_s is automatically called, and the to_s method for the class Pet returns "My name is #{@name.upcase}", that is what is output to the terminal.
# Line 20 is the same as line 18, and has the same results.
# Line 21 has the local variable `name`, which after line 17 is pointing to the Integer 43. When name is passed to the puts method, that's what's output
