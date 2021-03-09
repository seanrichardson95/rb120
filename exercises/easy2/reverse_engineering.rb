=begin
Write a class that will display:
ABC
xyz

when the following code is run:
=end

class Transform

  def initialize(str)
    @str = str
  end
  
  def uppercase
    @str.upcase
  end
  
  def self.lowercase(string)
    string.downcase
  end
end

my_data = Transform.new('abc')
puts my_data.uppercase
puts Transform.lowercase('XYZ')