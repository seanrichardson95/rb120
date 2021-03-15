class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # cols
                  [[1, 5, 9], [3, 5, 7]]              # diagonals

  def initialize
    @squares = {}
    reset
  end

  def []=(key, marker)
    @squares[key].marker = marker
  end

  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
  end

  def full?
    unmarked_keys.empty?
  end

  def someone_won?
    !!winning_marker
  end

  def winning_marker
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if three_identical_markers?(squares)
        return squares.first.marker
      end
    end
    nil
  end

  def immediate_threat(opponent_marker)
    WINNING_LINES.each do |line|
      three_squares = @squares.values_at(*line)
      next if all_marked?(three_squares)
      if count_marker(three_squares, opponent_marker) == 2
        line.each { |idx| return idx if @squares[idx].unmarked? }
      end
    end
    nil
  end

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  def draw
    puts "     |     |"
    puts "  #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}"
    puts "     |     |"
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength

  def reset
    (1..9).each { |key| @squares[key] = Square.new }
  end

  private

  def count_marker(squares, marker)
    squares.collect(&:marker).count(marker)
  end

  def three_identical_markers?(three_squares)
    return false unless all_marked?(three_squares)
    count_marker(three_squares, three_squares[0].marker) == 3
  end

  def all_marked?(line_of_squares)
    line_of_squares.all?(&:marked?)
  end
end

class Square
  INITIAL_MARKER = " "

  attr_accessor :marker

  def initialize
    @marker = INITIAL_MARKER
  end

  def to_s
    @marker
  end

  def unmarked?
    marker == INITIAL_MARKER
  end

  def marked?
    marker != INITIAL_MARKER
  end
end

class Player
  attr_reader :marker, :name
  attr_accessor :score

  def initialize(marker)
    @marker = marker
    @score = 0
  end

  def tally_win
    self.score += 1
  end

  def change_marker(new_marker)
    @marker = new_marker
  end

  def assign_name(name)
    @name = name
  end
end

class TTTGame
  HUMAN_MARKER = "X"
  COMPUTER_MARKER = "O"
  # put HUMAN_MARKER, COMPUTER_MARKER, or "Choose" here
  FIRST_TO_MOVE = HUMAN_MARKER
  MAX_WINS = 2
  COMPUTER_NAME = "R2D2"

  attr_reader :board, :human, :computer
  attr_accessor :current_marker, :score, :goes_first

  def initialize
    @board = Board.new
    @human = Player.new(HUMAN_MARKER)
    @computer = Player.new(COMPUTER_MARKER)
  end

  def play
    clear
    display_welcome_message
    assign_player_names
    choose_marker
    setup_first_move

    main_game

    display_goodbye_message
  end

  private

  def assign_player_names
    choice = nil
    loop do
      puts "What is your name?"
      choice = gets.chomp
      break unless choice == ''
      puts "Sorry, you have to input something"
    end
    human.assign_name(choice)
    computer.assign_name(COMPUTER_NAME)
  end

  def choose_marker
    choice = nil
    loop do
      puts "Please choose one character to be your marker"
      choice = gets.chomp
      break if valid_marker?(choice)
    end
    human.change_marker(choice)
  end

  def valid_marker?(choice)
    if choice.size != 1
      puts "I'm sorry, your marker must be one character"
    elsif choice.upcase == computer.marker
      puts "I'm sorry, that's the computer's marker"
    elsif choice == " "
      puts "Your marker cannot be a space"
    else
      true
    end
  end

  def setup_first_move
    self.goes_first = FIRST_TO_MOVE == "Choose" ? choose_first : FIRST_TO_MOVE

    self.current_marker = goes_first
  end

  def choose_first
    choice = nil
    loop do
      puts "Would you like to go first or second?"
      puts "Enter '1' to go first or '2' to go second"
      choice = gets.chomp
      break if %w(1 2).include? choice
      puts "Sorry, please input either '1' or '2'"
      puts ""
    end
    choice == '1' ? human.marker : computer.marker
  end

  def main_game
    loop do
      display_board
      player_move
      adjust_scores
      display_result
      break if game_over? || !play_again?
      reset
      display_play_again_message
    end
  end

  def player_move
    loop do
      current_player_moves
      break if board.someone_won? || board.full?
      clear_screen_and_display_board if human_turn?
    end
  end

  def human_moves
    puts "Choose a square (#{joinor(board.unmarked_keys)}): "
    square = 0
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts "Sorry, that's not a valid choice"
    end

    board[square] = human.marker
  end

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  def computer_moves
    # offensive move
    winning_spot = board.immediate_threat(computer.marker)
    if !!winning_spot
      board[winning_spot] = computer.marker
      return # no need for rest of code if spot already picked
    end

    # defensive move
    threat = board.immediate_threat(human.marker)
    if !!threat
      board[threat] = computer.marker
    elsif board.unmarked_keys.include?(5) # other moves
      board[5] = computer.marker
    else
      board[board.unmarked_keys.sample] = computer.marker
    end
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength

  def current_player_moves
    if human_turn?
      human_moves
      self.current_marker = computer.marker
    else
      computer_moves
      self.current_marker = human.marker
    end
  end

  def human_turn?
    current_marker == human.marker
  end

  def adjust_scores
    case board.winning_marker
    when human.marker
      human.tally_win
    when computer.marker
      computer.tally_win
    end
  end

  def clear
    system 'clear'
  end

  def reset
    board.reset
    self.current_marker = goes_first
    clear
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if %w(y n).include? answer
      puts "Sorry, must be y or n"
    end

    answer == 'y'
  end

  def max_wins_achieved?
    human.score == MAX_WINS || computer.score == MAX_WINS
  end

  def game_over?
    if max_wins_achieved?
      display_ultimate_winner
      true
    else
      false
    end
  end

  def display_ultimate_winner
    case board.winning_marker
    when human.marker
      puts "Congratulations, #{human.name} is the ULTIMATE WINNER!"
    when computer.marker
      puts "#{computer.name} is the ULTIMATE WINNER"
      puts "Better luck next time!"
    end
  end

  def display_play_again_message
    puts "Let's play again!"
    puts ""
  end

  def display_welcome_message
    puts "Welcome to Tic Tac Toe!"
  end

  def display_goodbye_message
    puts "Thanks for playing Tic Tac Toe! Goodbye!"
  end

  def display_board
    puts "You're a #{human.marker}. #{computer.name} is a #{computer.marker}."
    puts ""
    board.draw
    puts ""
  end

  def display_scoreboard
    puts ""
    puts "------Scoreboard------"
    puts "Human: #{human.score}   Computer: #{computer.score}"
    unless max_wins_achieved?
      puts "First to #{MAX_WINS} is the ultimate winner!"
    end
    puts ""
  end

  def display_result
    clear_screen_and_display_board

    case board.winning_marker
    when human.marker
      puts "#{human.name} won!"
    when computer.marker
      puts "#{computer.name} won!"
    else
      puts "It's a tie!"
    end

    display_scoreboard
  end

  def clear_screen_and_display_board
    clear
    display_board
  end

  def joinor(nums, delim=", ", last_delim="or")
    if nums.size == 1
      nums[0].to_s
    elsif nums.size == 2
      "#{nums[0]} #{last_delim} #{nums[1]}"
    elsif nums.size > 2
      nums[0..-2].join(delim) + " #{last_delim} " + nums[-1].to_s
    end
  end
end

game = TTTGame.new
game.play
