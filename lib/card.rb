# require_relative 'suit'
require 'colorize'
require_relative 'card_constants'

class Card
  include CardConstants

  attr_reader :suit, :rank

  def initialize(suit, rank)
    raise ArgumentError, 'Incorrect rank.' unless RANKS.include?(rank)
    raise ArgumentError, 'Incorrect suit.' unless SUITS.include?(suit)

    @suit = suit
    @rank = rank
    @color = COLORS[suit]
  end

  def <=>(other)
    suit_comparison = suit_index(@suit) <=> suit_index(other.suit)
    return suit_comparison unless suit_comparison.zero?

    rank_index(@rank) <=> rank_index(other.rank)
  end

  def ==(other)
    suit == other.suit && rank == other.rank
  end

  alias eql? ==

  def hash
    [@suit, @rank, @color].hash
  end

  def to_s
    "#{rank_string} #{suit_string}".colorize(color: @color)
  end

  def inspect
    "<#{self}>"
  end

  private

  def rank_index(rank)
    RANKS.index(rank)
  end

  def suit_index(suit)
    SUITS.index(suit)
  end

  def rank_string
    RANK_STRINGS[rank_index(@rank)]
  end

  def suit_string
    SUIT_STRINGS[suit_index(@suit)]
  end
end
