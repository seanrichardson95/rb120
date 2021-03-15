# If we have this code:

class Greeting
  def self.greet(message)
    puts message
  end
end

class Hello < Greeting
  def self.hi
    greet("Hello")
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end

# What happens in each of the following cases:

# case 1:
hello = Hello.new
# hello.hi # outputs: Hello  Correct

# case 2:
hello = Hello.new
# hello.bye # NoMethodError  Correct

# case 3:
hello = Hello.new
# hello.greet # ArgumentError Correct

# case 4:
hello = Hello.new
# hello.greet("Goodbye") # outputs: Goodbye  Correct

# case 5:
Hello.hi # NoMethodError?  Correct