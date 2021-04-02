# Update this class so you can use it to determine the lowest ranking and highest ranking cards in an Array of Card objects:
require 'pry'

class Deck
  RANKS = ((2..10).to_a + %w(Jack Queen King Ace)).freeze
  SUITS = %w(Hearts Clubs Diamonds Spades).freeze
  
  def initialize
    @deck = shuffled_deck
  end
  
  def shuffled_deck
    new_deck = []
    RANKS.each do |rank|
      SUITS.each { |suit| new_deck << Card.new(rank, suit) }
    end
    new_deck.shuffle
  end
  
  def draw
    card_drawn = @deck.pop
    reset if @deck.empty?
    card_drawn
  end
  
  def reset
    @deck = shuffled_deck
  end
end


class Card
  include Comparable
  attr_reader :rank, :suit

  VALUES = { 'Jack' => 11, 'Queen' => 12, 'King' => 13, 'Ace' => 14 }

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def to_s
    "#{rank} of #{suit}"
  end

  def value
    VALUES.fetch(rank, rank)
  end

  def <=>(other_card)
    value <=> other_card.value
  end
end

class PokerHand
  attr_reader :cards
  
  def initialize(deck)
    @cards = []
    5.times {|_| @cards << deck.draw}
  end

  def print
    cards.each { |card| puts card }
  end

  def evaluate
    case
    when royal_flush?     then 'Royal flush'
    when straight_flush?  then 'Straight flush'
    when four_of_a_kind?  then 'Four of a kind'
    when full_house?      then 'Full house'
    when flush?           then 'Flush'
    when straight?        then 'Straight'
    when three_of_a_kind? then 'Three of a kind'
    when two_pair?        then 'Two pair'
    when pair?            then 'Pair'
    else                       'High card'
    end
  end

  private

  def royal_flush?
    straight? && flush? && (cards.sort.last.value == 14)
  end

  def straight_flush?
    straight? && flush?
  end

  def four_of_a_kind?
    values = cards.sort.map {|card| card.value}
    2.times do |i|
      return true if values[i..i+3].all? {|val| val == values[i]}
    end
    false
  end

  def full_house?
    values = cards.sort.map {|card| card.value}
    if (values[0] == values[1] && values[2] ==
        values[3] && values[2] == values[4]) ||
       (values[0] == values[1] && values[0] ==
        values[2] && values[3] == values[4])
      true
    else
      false
    end
  end

  def flush?
    cards.all? {|card| card.suit == cards[0].suit}
  end

  def straight?
    values = sorted_card_values
    1.upto(4) { |i| 
      return false if (values[i] - values[i-1] != 1)
    }
    true
  end

  def three_of_a_kind?
    values = sorted_card_values
    2.upto(4) {|i| 
      if values[i] == values[i-1] &&  values[i] == values[i-2]
        return true
      end
    }
    false
  end

  def two_pair?
    values = sorted_card_values
    pairs = 0
    1.upto(4) {|i| pairs += 1 if values[i] == values[i-1] }
    pairs == 2
  end

  def pair?
    values = sorted_card_values
    # binding.pry
    pairs = 0
    1.upto(4) {|i| pairs += 1 if values[i] == values[i-1] }
    pairs == 1
  end
  
  def sorted_card_values
    cards.sort.map {|card| card.value}
  end
end

hand = PokerHand.new(Deck.new)
hand.print
puts hand.evaluate

# Danger danger danger: monkey
# patching for testing purposes.
class Array
  alias_method :draw, :pop
end

# Test that we can identify each PokerHand type.
hand = PokerHand.new([
  Card.new(10,      'Hearts'),
  Card.new('Ace',   'Hearts'),
  Card.new('Queen', 'Hearts'),
  Card.new('King',  'Hearts'),
  Card.new('Jack',  'Hearts')
])
puts hand.evaluate == 'Royal flush'

hand = PokerHand.new([
  Card.new(8,       'Clubs'),
  Card.new(9,       'Clubs'),
  Card.new('Queen', 'Clubs'),
  Card.new(10,      'Clubs'),
  Card.new('Jack',  'Clubs')
])
puts hand.evaluate == 'Straight flush'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(3, 'Diamonds')
])
puts hand.evaluate == 'Four of a kind'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(5, 'Hearts')
])
puts hand.evaluate == 'Full house'

hand = PokerHand.new([
  Card.new(10, 'Hearts'),
  Card.new('Ace', 'Hearts'),
  Card.new(2, 'Hearts'),
  Card.new('King', 'Hearts'),
  Card.new(3, 'Hearts')
])
puts hand.evaluate == 'Flush'

hand = PokerHand.new([
  Card.new(8,      'Clubs'),
  Card.new(9,      'Diamonds'),
  Card.new(10,     'Clubs'),
  Card.new(7,      'Hearts'),
  Card.new('Jack', 'Clubs')
])
puts hand.evaluate == 'Straight'

hand = PokerHand.new([
  Card.new('Queen', 'Clubs'),
  Card.new('King',  'Diamonds'),
  Card.new(10,      'Clubs'),
  Card.new('Ace',   'Hearts'),
  Card.new('Jack',  'Clubs')
])
puts hand.evaluate == 'Straight'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(6, 'Diamonds')
])
puts hand.evaluate == 'Three of a kind'

hand = PokerHand.new([
  Card.new(9, 'Hearts'),
  Card.new(9, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(8, 'Spades'),
  Card.new(5, 'Hearts')
])
puts hand.evaluate == 'Two pair'

hand = PokerHand.new([
  Card.new(2, 'Hearts'),
  Card.new(9, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(9, 'Spades'),
  Card.new(3, 'Diamonds')
])
puts hand.evaluate == 'Pair'

hand = PokerHand.new([
  Card.new(2,      'Hearts'),
  Card.new('King', 'Clubs'),
  Card.new(5,      'Diamonds'),
  Card.new(9,      'Spades'),
  Card.new(3,      'Diamonds')
])
puts hand.evaluate == 'High card'