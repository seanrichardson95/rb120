class FourLegs
  def run
    'running!'
  end

  def jump
    'jumping!'
  end
end

class Cat < FourLegs
  def speak
    'meow!'
  end
end

class Dog < FourLegs
  
  def speak
    'bark!'
  end
  
  def swim
    'swimming!'
  end

  def fetch
    'fetching!'
  end
end

class Bulldog < Dog
  def swim
    "can't swim!"
  end
end

pete = FourLegs.new
kitty = Cat.new
dave = Dog.new
bud = Bulldog.new

puts pete.run                # => "running!"
# pete.speak              # => NoMethodError

puts kitty.run               # => "running!"
puts kitty.speak             # => "meow!"
# kitty.fetch             # => NoMethodError

puts dave.speak              # => "bark!"

puts bud.run                 # => "running!"
puts bud.swim                # => "can't swim!"