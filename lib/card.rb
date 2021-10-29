require_relative 'suit'
class Card
  RANKS = %w[A J Q K] + (2..10).to_a

  attr_reader :suit, :rank

  def initialize(suit, rank)
    raise ArgumentError, 'Incorrect rank.' unless RANKS.include?(rank)
    raise ArgumentError, 'Incorrect suit.' unless suit.is_a?(Suit)

    @suit = suit
    @rank = rank
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
