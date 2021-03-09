class RPSGame
  attr_accessor :human, :computer, :winner

  MAX_WINS = 10

  def initialize
    @human = Human.new
    @computer = Computer.new
    @moves = { human.name => [], computer.name => [] }
    @winner = nil
  end

  def play
    display_welcome_message
    loop do
      make_moves!
      analyze_moves!
      display_score
      break if game_over? || !continue?
      system "clear"
    end
    goodbye
  end

  private

  def display_welcome_message
    system 'clear'
    puts "Welcome to Rock, Paper, Scissors!"
  end

  def make_moves!
    human.choose
    computer.choose
    record_moves!
    display_moves
  end

  def analyze_moves!
    self.winner = determine_winner!
    update_score!
    display_winner
  end

  def record_moves!
    @moves[human.name] << human.move.to_s
    @moves[computer.name] << computer.move.to_s
  end

  def update_score!
    winner.score += 1 if !@winner.nil?
  end

  def display_winner
    if @winner.nil?
      puts "It's a tie!"
    else
      puts "#{winner.name} won!"
    end
  end

  def determine_winner!
    if human.move > computer.move
      human
    elsif computer.move > human.move
      computer
    end
  end

  def display_moves
    puts "#{human.name} chose #{human.move}"
    puts "#{computer.name} chose #{computer.move}"
  end

  def display_score
    human_display = "#{human.name}: #{human.score}"
    computer_display = "#{computer.name}: #{computer.score}"
    dash = "-" * ((human.name.size + computer.name.size).to_f / 2 + 2).ceil
    space = " " * ((dash.size * 2) - human.name.size - computer.name.size + 4)
    puts "\n" + dash + "Scoreboard" + dash
    puts human_display + space + computer_display
    puts "First to #{MAX_WINS} wins is the ultimate winner!" unless game_over?
    puts ""
  end

  def display_past_moves
    spacing = 6
    puts "\n-------History of Moves-------"
    puts " " * 11 + human.name.to_s + " " * spacing + computer.name.to_s
    @moves.values[0].size.times do |i|
      human_move = @moves[human.name][i]
      computer_move = @moves[computer.name][i]
      x = spacing + human.name.size - human_move.size - 1
      if i < 9
        puts "Round #{i + 1}:   #{human_move}" + " " * x + " #{computer_move}"
      else
        puts "Round #{i + 1}:  #{human_move}" + " " * x + " #{computer_move}"
      end
    end
    puts ""
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors. Good bye!"
  end

  def display_end_results
    if human.score == MAX_WINS
      puts "Congratulations! #{human.name} is the ultimate winner!"
    else
      puts "#{computer.name} is the ultimate winner!"
      puts "#{computer.name}: Primary directive achieved, bleep bloop"
    end
  end

  def game_over?
    (human.score == MAX_WINS) || (computer.score == MAX_WINS)
  end

  def continue?
    answer = nil
    loop do
      puts "Would you like to continue? (y/n)"
      answer = gets.chomp
      break if ['y', 'n'].include? answer.downcase
      puts "Sorry, must be y or n"
    end
    answer.downcase == 'y'
  end

  def goodbye
    display_end_results if game_over?
    display_past_moves
    display_goodbye_message
  end
end

class Player
  attr_accessor :move, :name, :score

  def initialize
    set_name
    @score = 0
  end

  def hand_sign(move)
    case move
    when 'rock' then Rock.new
    when 'paper' then Paper.new
    when 'scissors' then Scissors.new
    when 'lizard' then Lizard.new
    when 'spock' then Spock.new
    end
  end
end

class Human < Player
  def set_name
    n = ""
    loop do
      puts "What's your name?"
      n = gets.chomp
      break unless n.empty?
      puts "Sorry, must enter a value?"
    end
    self.name = n
  end

  def choose
    choice = nil
    loop do
      puts "Please choose rock, paper, scissors, lizard, or spock"
      puts "('r', 'p', 'sc', 'l', and 'sp' are also accepted)"
      choice = gets.chomp.downcase
      break if Move::VALUES.include? choice
      puts "Sorry, invalid choice."
    end
    choice = Move.full_choice(choice) if choice.size <= 2
    self.move = hand_sign(choice)
  end
end

class Computer < Player
  R2D2 = ['rock']
  HAL = ['paper', 'paper', 'rock', 'paper', 'scissors', 'lizard', 'spock']
  CHAPPIE = ['rock', 'paper', 'lizard', 'spock', 'lizard', 'spock',
             'lizard', 'spock']
  SONNY = ['rock', 'paper', 'scissors', 'lizard', 'spock']
  NUMBER_5 = ['rock', 'paper', 'scissors']

  MOVE_SETS = { 'R2D2' => R2D2, 'Hal' => HAL, 'Chappie' => CHAPPIE,
                'Sonny' => SONNY, 'Number 5' => NUMBER_5 }

  def set_name
    self.name = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5'].sample
  end

  def choose
    self.move = hand_sign(MOVE_SETS[name].sample)
  end
end

class Move
  VALUES = ['rock', 'paper', 'scissors', 'lizard', 'spock',
            'r', 'p', 'sc', 'l', 'sp']

  def self.full_choice(abbr)
    case abbr
    when 'r' then 'rock'
    when 'p' then 'paper'
    when 'sc' then 'scissors'
    when 'l' then 'lizard'
    when 'sp' then 'spock'
    end
  end

  def to_s
    self.class.to_s.downcase
  end
end

class Rock < Move
  def >(other_move)
    other_move.is_a?(Scissors) || other_move.is_a?(Lizard)
  end
end

class Paper < Move
  def >(other_move)
    other_move.is_a?(Rock) || other_move.is_a?(Spock)
  end
end

class Scissors < Move
  def >(other_move)
    other_move.is_a?(Paper) || other_move.is_a?(Lizard)
  end
end

class Lizard < Move
  def >(other_move)
    other_move.is_a?(Paper) || other_move.is_a?(Spock)
  end
end

class Spock < Move
  def >(other_move)
    other_move.is_a?(Rock) || other_move.is_a?(Scissors)
  end
end

RPSGame.new.play
