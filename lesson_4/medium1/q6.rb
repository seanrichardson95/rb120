# If we have these two methods:

class Computer1
  attr_accessor :template

  def create_template
    @template = "template 14231"
  end

  def show_template
    template
  end
end

# and

class Computer2
  attr_accessor :template

  def create_template
    self.template = "template 14231"
  end

  def show_template
    self.template
  end
end

# What is the difference in the way the code works?

# Both codes produce the same results, they just do it a little bit differently. Computer1 assigns the instance variable template by using @template, while Computer2 does it by using self.template. In this circumstance, @ and self are interchangable so the result is the same.

# In Computer1, the show_template instance method calls the getter method template in order to return @template. In Computer2, @template is referenced directly through self.template.