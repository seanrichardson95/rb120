class Participant
  BUST_LIMIT = 21

  attr_accessor :hand
  attr_reader :busted, :total

  def initialize
    @hand = []
    @total = 0
    @busted = false
  end

  def hit(deck)
    puts "#{self} decided to hit!"
    hand << deck.deal
    new_card = hand[-1].to_s
    new_card = new_card[0].upcase + new_card[1..-1]
    puts "#{new_card} is drawn\n"
    sleep(1.5)
  end

  def stay
    puts "#{self} decided to stay!"
  end

  def busted?
    @busted = total > BUST_LIMIT
  end

  def calculate_total
    sum = 0
    num_aces = 0
    hand.each do |card|
      sum, num_aces = calculate_card_value(card, sum, num_aces)
    end
    num_aces.times { |_| sum -= 10 if sum > BUST_LIMIT }
    @total = sum
    busted?
  end

  def calculate_card_value(card, sum, num_aces)
    if card.number?
      sum += card.value.to_i
    elsif card.face?
      sum += 10
    elsif card.ace?
      num_aces += 1
      sum += 11
    end
    return sum, num_aces
  end

  def reset
    self.hand = []
    @total = 0
    @busted = false
  end

  def joinand(nums, delim=", ", last_delim="and")
    if nums.size == 1
      nums[0].to_s
    elsif nums.size == 2
      "#{nums[0]} #{last_delim} #{nums[1]}"
    elsif nums.size > 2
      nums[0..-2].join(delim) + " #{last_delim} " + nums[-1].to_s
    end
  end
end

class Player < Participant
  def show_hand
    print "#{self} have "
    puts joinand(hand.map(&:to_s))
  end

  def to_s
    "You"
  end

  def hit(deck)
    system 'clear'
    super
  end

  def choose_hit_or_stay
    puts "Would you like to 'hit' or 'stay'?"
    answer = nil
    loop do
      answer = gets.chomp.downcase
      break if ['hit', 'stay'].include?(answer)
      puts "I'm sorry, please only enter 'hit' or 'stay'"
    end
    answer
  end

  def display_total
    puts "#{self} total is #{total}"
  end
end

class Dealer < Participant
  def show_hand(hidden=false)
    print "#{self} has "
    if hidden
      puts hand[0].to_s + " and a hidden card"
    else
      puts joinand(hand.map(&:to_s))
    end
  end

  def to_s
    "The Dealer"
  end

  def choose_hit_or_stay
    total >= 17 ? 'stay' : 'hit'
  end

  def display_total
    puts "#{self}'s total is #{total}"
  end

  def reveal_card
    puts "#{self} reveals its other card"
    puts "It's a #{hand[-1]}!"
    sleep(2.5)
  end
end

class Deck
  VALUES = %w(A 2 3 4 5 6 7 8 9 10 J Q K)
  SUITS = ['♤', '♡', '♧', '♢']

  attr_accessor :cards

  def initialize
    @cards = new_deck.shuffle
  end

  def new_deck
    arr = []
    VALUES.each do |value|
      SUITS.each { |suit| arr << Card.new(value, suit) }
    end
    arr
  end

  def deal
    cards.pop
  end
end

class Card
  NUMBERS = %w(2 3 4 5 6 7 8 9 10)
  FACES = %w(J Q K)
  ACE = "A"

  attr_reader :value, :suit

  def initialize(value, suit)
    @value = value
    @suit = suit
  end

  def number?
    NUMBERS.include?(value)
  end

  def face?
    FACES.include?(value)
  end

  def ace?
    value == ACE
  end

  def to_s
    if value == "A" || value == "8"
      "an #{value}#{suit}"
    else
      "a #{value}#{suit}"
    end
  end
end

class Game
  attr_accessor :player, :dealer, :deck
  attr_reader :winner

  def initialize
    @player = Player.new
    @dealer = Dealer.new
    @deck = Deck.new
  end

  def start
    display_welcome_message
    loop do
      clear
      deal_cards
      player_turn
      dealer_turn
      show_result
      play_again? ? reset : break
    end
    display_goodbye_message
  end

  def reset
    player.reset
    dealer.reset
  end

  def display_welcome_message
    puts "Welcome to Twenty-One!"
    display_instructions if read_instructions?
  end

  def read_instructions?
    puts "Would you like to read the instructions?"
    puts "Enter 'y' to see the instructions or 'n' to start the game"
    answer = nil
    loop do
      answer = gets.chomp.downcase
      break if %w(y n).include?(answer)
      puts "Sorry, please only input 'y' or 'n'"
    end
    answer == 'y'
  end

  # rubocop:disable Metrics/MethodLength
  # rubocop:disable Layout/LineLength
  def display_instructions
    clear
    puts "Twenty-One is a card game consisting of a dealer and a player,"
    puts "where the participants try to get as close to 21 as possible without going over."
    puts "\nHere is an overview of the game:"
    puts "- Both participants are initially dealt 2 cards from a 52-card deck."
    puts "- The player takes the first turn, and can \"hit\" or \"stay\"."
    puts "- If the player busts, he loses. If he stays, it's the dealer's turn."
    puts "- The dealer must hit until his cards add up to at least 17."
    puts "- If he busts, the player wins. If both player and dealer stays, then the highest total wins."
    puts "- If both totals are equal, then it's a tie, and nobody wins."
    continue(" to the game")
  end
  # rubocop:enable Metrics/MethodLength
  # rubocop:enable Layout/LineLength

  def continue(message='')
    puts "(Press 'enter' to continue#{message})"
    gets
    clear
  end

  def play_again?
    puts "Would you like to play again?"
    answer = nil
    loop do
      answer = gets.chomp.downcase
      break if %w(y n).include?(answer)
      puts "Sorry, please only input 'y' or 'n'"
    end
    answer == 'y'
  end

  def display_goodbye_message
    puts "Thanks for playing Twenty-One! Goodbye!"
  end

  def deal_cards
    2.times do |_|
      player.hand << deck.deal
      dealer.hand << deck.deal
    end
  end

  def clear
    system 'clear'
  end

  def dealer_turn
    return if player.busted
    dealer.reveal_card
    dealer_moves
    continue(" to the final result")
  end

  def dealer_moves
    loop do
      calculate_and_display_total(dealer)
      break if dealer.busted
      if dealer.choose_hit_or_stay == 'stay'
        dealer.stay
        break
      else
        dealer.hit(deck)
      end
    end
  end

  def calculate_and_display_total(participant)
    participant.calculate_total
    participant.show_hand
    participant.display_total
  end

  def player_turn
    decision = nil
    loop do
      dealer.show_hand(hidden: true)
      calculate_and_display_total(player)
      break if player.busted
      decision = player.choose_hit_or_stay
      decision == 'stay' ? break : player.hit(deck)
    end
    player.stay if decision == 'stay'
    continue
  end

  def show_result
    if player.busted
      puts "#{player} busted! #{dealer} wins!"
    elsif dealer.busted
      puts "#{dealer} busted! #{player} wins!"
    else
      display_totals
      determine_winner_no_bust
    end
  end

  def display_totals
    player.display_total
    dealer.display_total
  end

  def determine_winner_no_bust
    if player.total > dealer.total
      puts "#{player} win!"
    elsif player.total < dealer.total
      puts "#{dealer} wins!"
    else
      puts "It's a tie!"
    end
  end
end

Game.new.start
