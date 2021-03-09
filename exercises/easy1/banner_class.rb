=begin
Behold this incomplete class for constructing boxed banners. (below)

Complete this class so that the test cases shown below work as intended. You are free to add any methods or instance variables you need. However, do not make the implementation details public.

You may assume that the input will always fit in your terminal window.

Test Cases:
banner = Banner.new('To boldly go where no one has gone before.')
puts banner
+--------------------------------------------+
|                                            |
| To boldly go where no one has gone before. |
|                                            |
+--------------------------------------------+

banner = Banner.new('')
puts banner
+--+
|  |
|  |
|  |
+--+


Understanding the problem:
-Edit initialize so that it saves the message in @message
-Create implementation for horizontal_rule
  -will look like +--...--+
  -minimum line is "+--+", therefore formula is "+-" + -*message.size + "-+"
-Create implementation for empty_line
  -will look like |  ...  |
  -formula: "| " + " "*message.size + " |"
  
  
Further explanation:
-create @banner_width variable
  -does it refer to entire banner? No, not to the outside of the banner, but yes to the inside of the banner
  -edit horizontal and empty lines to get rid of extra "-" and " "
-if @banner_width is too small, then use message size and print a message saying that's what happened
-if the @banner_width is too wide, that is fine
  -have to edit the middle banner to make sure that @message is centered
  -
=end

class Banner
  def initialize(message, banner_width=2)
    @message = message
    if banner_width >= (message.size + 2)
      @banner_width = banner_width
    else
      @banner_width = message.size + 2
      puts "FYI, your banner width was too small, so we used the size of the message plus two as the banner width."
      puts "The length of your banner is #{@banner_width}"
    end
  end

  def to_s
    [horizontal_rule, empty_line, message_line, empty_line, horizontal_rule].join("\n")
  end

  private

  def horizontal_rule
    "+" + "-"*@banner_width + "+"
  end

  def empty_line
    "|" + " "*@banner_width + "|"
  end

  def message_line
    left_spaces = (@banner_width - @message.size) / 2
    right_spaces = (@banner_width - @message.size) - left_spaces
    "|" + " "*left_spaces + @message + " "*right_spaces + "|"
  end
end

# banner = Banner.new('To boldly go where no one has gone before.')
# puts banner

banner = Banner.new('yep', 8)
puts banner

banner2 = Banner.new('yep', 9)
puts banner2

banner3 = Banner.new("")
puts banner3

banner4 = Banner.new("hello", 3)
puts banner4

banner5 = Banner.new("hello", 7)
puts banner5