=begin

Update this code so that when you run it, you see the following output:
My cat Pudding is 7 years old and has black and white fur.
My cat Butterscotch is 10 years old and has tan and white fur.

=end

class Pet
  def initialize(name, age)
    @name = name
    @age = age
  end
end

class Cat < Pet
  def initialize(name, age, colors)
    super(name, age)
    @colors = colors
  end
  
  def to_s
    "My cat #{@name} is #{@age} years old and has #{@colors} fur."
  end
  
end

pudding = Cat.new('Pudding', 7, 'black and white')
butterscotch = Cat.new('Butterscotch', 10, 'tan and white')
puts pudding, butterscotch

# Further Exploration
# An alternative approach to this problem would be to modify the Pet class to accept a colors parameter. If we did this, we wouldn't need to supply an initialize method for Cat.

# Why would we be able to omit the initialize method? Would it be a good idea to modify Pet in this way? Why or why not? How might you deal with some of the problems, if any, that might arise from modifying Pet?

# We'd be able to omit the initialize method because then Cat would automatically refer to Pet, and since Pet.initialize takes all 3 arguments, the code will work.

# I personally think its a great idea. I can't really see any downsides. It's not like there are any pets that aren't any colors, unless you personally can't see them because you are blind.