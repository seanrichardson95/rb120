=begin
Complete this program so that it produces the expected output:

Expected output:
The author of "Snow Crash" is Neil Stephenson.
book = "Snow Crash", by Neil Stephenson.
=end

class Book
  attr_accessor :title, :author
  
  def to_s
    %("#{title}", by #{author})
  end
end

book = Book.new
book.author = "Neil Stephenson"
book.title = "Snow Crash"
puts %(The author of "#{book.title}" is #{book.author}.)
puts %(book = #{book}.)

# Further Explanation
# What do you think of this way of creating and initializing Book objects? (The two steps are separate.) Would it be better to create and initialize at the same time like in the previous exercise? What potential problems, if any, are introduced by separating, the steps?

# I think the process in the previous exercise is better. If you're initializing an empty book, with no author or title, then why do it? If you want to initialize the book and have the author and title handy, might as well have those details input when you initialize the book.
# If you keep those steps separate, you might forget to do the extra steps, then you'd have an empty book with no state. Also, the names and title can be routinely changed in this example, which unless the name or title of a book changes (which almost never happens) you don't really need that functionality.