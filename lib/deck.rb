require_relative 'card'
require_relative 'suit'
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
    cards.shuffle!
  end

  def deal_card
    @cards.pop
  end
end
