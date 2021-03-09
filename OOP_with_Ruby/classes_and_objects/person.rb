class Person
  attr_accessor :name
  def initialize(name)
    @name = name
  end
end

bob = Person.new("Steve")
bob.name = "Bob"
puts bob.name

# this produces an error because :name was passed into attr_reader, which only provides a getter, not a setter function. In order for this code to work, we would need to use attr_writer or attr_accessor on line 2 instead