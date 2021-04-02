# Create an object-oriented number guessing class for numbers in the range 1 to 100, with a limit of 7 guesses per game. The game should play like this:

# Note that a game object should start a new game with a new number to guess with each call to #play.

class RandomNumber
  def initialize(low, high)
    @num = rand(low..high)
  end
  
  def <(other_num)
    @num < other_num
  end
  
  def >(other_num)
    @num > other_num
  end
  
  def ==(other_num)
    @num == other_num
  end
  
  def to_s
    @num.to_s
  end
end

class GuessingGame
  LOW_LIMIT = 1
  HIGH_LIMIT = 100
  INITIAL_GUESSES = 7
  
  attr_accessor :guess, :number
  
  def play
    @number = RandomNumber.new(LOW_LIMIT, HIGH_LIMIT)
    @guesses_left = INITIAL_GUESSES
    loop do
      puts ""
      display_remaining_guesses
      get_guess
      @guesses_left -= 1
      break if correct_guess? || @guesses_left == 0
      display_hint
    end
    display_results
  end
  
  def display_remaining_guesses
    puts "You have #{@guesses_left} remaining."
  end
  
  def display_hint
    if number > guess
      puts "Your guess is too low"
    else
      puts "Your guess is too high"
    end
  end
  
  def display_results
    if correct_guess?
      puts "You won!"
    else
      puts "You've run out of guesses, better luck next time!"
    end
  end
  
  def correct_guess?
    number == guess
  end
  
  def get_guess
    answer = 0
    loop do
      print "Enter a number between #{LOW_LIMIT} and #{HIGH_LIMIT}: "
      answer = gets.chomp.to_i
      break if (LOW_LIMIT..HIGH_LIMIT).include?(answer)
      print "Invalid guess. "
    end
    self.guess = answer
  end
end

# Further Exploration

In this instance, I see no need for a player class. There's no player state, except maybe the guess. If we wanted to keep track of wins, or want to keep track of past guesses or if there were more than one player, it might make sense to have a player class.

The Player would be a collaborative object within the game, much like we did for TTT and 21.

game = GuessingGame.new
game.play
puts game.number

# You have 7 guesses remaining.
# Enter a number between 1 and 100: 104
# Invalid guess. Enter a number between 1 and 100: 50
# Your guess is too low.

# You have 6 guesses remaining.
# Enter a number between 1 and 100: 75
# Your guess is too low.

# You have 5 guesses remaining.
# Enter a number between 1 and 100: 85
# Your guess is too high.

# You have 4 guesses remaining.
# Enter a number between 1 and 100: 0
# Invalid guess. Enter a number between 1 and 100: 80

# You have 3 guesses remaining.
# Enter a number between 1 and 100: 81
# That's the number!

# You won!

# game.play

# You have 7 guesses remaining.
# Enter a number between 1 and 100: 50
# Your guess is too high.

# You have 6 guesses remaining.
# Enter a number between 1 and 100: 25
# Your guess is too low.

# You have 5 guesses remaining.
# Enter a number between 1 and 100: 37
# Your guess is too high.

# You have 4 guesses remaining.
# Enter a number between 1 and 100: 31
# Your guess is too low.

# You have 3 guesses remaining.
# Enter a number between 1 and 100: 34
# Your guess is too high.

# You have 2 guesses remaining.
# Enter a number between 1 and 100: 32
# Your guess is too low.

# You have 1 guesses remaining.
# Enter a number between 1 and 100: 32
# Your guess is too low.

# You have no more guesses. You lost!