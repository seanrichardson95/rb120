class Student
  attr_accessor :name
  
  def initialize(name, grade)
    @name = name
    @grade = grade
  end
  
  def better_grade_than?(person)
    grade > person.grade
  end
  
  
  protected
  
  def grade
    @grade
  end
  
end

joe = Student.new("Joe", 97)
bob = Student.new("Bob", 69)

puts "Well done!" if joe.better_grade_than?(bob)