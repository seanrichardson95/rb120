# Q: What is a module? What is its purpose? How do we use them with our classes? Create a module for the class you created in exercise 1 and include it properly.

# My answer:
# A module contains shared behavior, but you can't create an object with a module. It's more for just holding a bunch of methods and easily putting those methods into different classes using the `include` method.


module Work
  def report(project)
    puts "I am working on #{project}"
  end
end

class Engineer
  include Work
end

sean = Engineer.new
sean.report("lesson 1")