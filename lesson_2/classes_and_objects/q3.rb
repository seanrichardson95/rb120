class Person
  attr_accessor :first_name, :last_name
  
  def initialize(first_name='', last_name='')
    @first_name = first_name
    @last_name = last_name
  end
  
  def name
    return first_name if last_name.size == 0
    first_name + " " + last_name
  end
  
  def name=(full_name)
    parts = full_name.split
    self.first_name = parts[0]
    self.last_name = parts[1] if parts.size > 1
  end
  
  
end


bob = Person.new("Robert Smith")
puts "The person's name is: #{bob}"
