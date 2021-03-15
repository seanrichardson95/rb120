class Cat
  @@cats_count = 0

  def initialize(type)
    @type = type
    @age  = 0
    @@cats_count += 1
  end

  def self.cats_count
    @@cats_count
  end
end

puts Cat.cats_count
maxie = Cat.new("Tortioushell")
puts Cat.cats_count
nova = Cat.new("black/white")
brahma = Cat.new("tabby")

puts Cat.cats_count