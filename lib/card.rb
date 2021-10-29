require_relative 'suit'
require_relative 'card_constants'

class Card
  include CardConstants

  attr_reader :suit, :rank

  def initialize(suit, rank)
    raise ArgumentError, 'Incorrect rank.' unless RANKS.include?(rank)
    raise ArgumentError, 'Incorrect suit.' unless suit.is_a?(Suit) && SUITS.include?(suit)

    @suit = suit
    @rank = rank
  end

  def <=>(other)
    my_suit_index = SUITS.index(@suit)
    other_suit_index = SUITS.index(other.suit)
    suit_comparison = my_suit_index <=> other_suit_index
    return suit_comparison unless suit_comparison.zero?

    my_rank_index = RANKS.index(@rank)
    other_rank_index = RANKS.index(other.rank)

    my_rank_index <=> other_rank_index
  end

  def ==(other)
    suit == other.suit && rank == other.rank
  end

  alias eql? ==

  def hash
    [@name, @color, @symbol].hash
  end

  def to_s
    color = @suit.color
    "#{@rank} #{@suit}".colorize(color: color)
  end

  def inspect
    "<#{self}>"
  end
end
