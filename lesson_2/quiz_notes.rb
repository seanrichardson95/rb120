class Character
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def speak
    "#{name} is speaking."
  end
end

class Knight < Character
  def name
    "Sir " + super
  end
end

class Thief < Character
  def speak
    "#{name} is whispering..."
  end 
end

sir_gallant = Knight.new("Gallant")
puts sir_gallant.name # => "Sir Gallant"
puts sir_gallant.speak # => "Sir Gallant is speaking."

sneak = Thief.new("Sneak")
puts sneak.name # => "Sneak"
puts sneak.speak