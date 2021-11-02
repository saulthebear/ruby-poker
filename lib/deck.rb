require 'byebug'
require_relative 'card'
require_relative 'card_constants'

class Deck
  include CardConstants

  attr_reader :cards

  def initialize
    @cards = []

    SUITS.each do |suit|
      RANKS.each do |rank|
        @cards << Card.new(suit, rank)
      end
    end

    shuffle!
  end

  def deal_card
    @cards.pop
  end

  def deal_cards(num)
    raise ArgumentError unless num.positive? && num < 53

    cards = []
    num.times { cards << deal_card }
    cards
  end

  def return_cards(cards)
    unless cards.all? { |card| card.is_a?(Card) }
      raise ArgumentError, 'Only Card instances can be returned'
    end

    if cards.any? { |card| @cards.include?(card) }
      raise ArgumentError, 'Duplicate cards cannot be returned'
    end

    @cards += cards

    shuffle!
  end

  def shuffle!
    @cards = @cards.shuffle
  end
end
