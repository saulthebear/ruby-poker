require_relative 'player'
require_relative 'deck'
require_relative 'hand'

class Game

  attr_reader :players, :deck, :pot

  def initialize(number_of_players)
    unless number_of_players.is_a?(Integer) && number_of_players.positive?
      raise ArgumentError, 'number_of_players must be an integer greater than 0'
    end

    @deck = Deck.new
    @pot = 0

    @players = []
    number_of_players.times do
      @players << Player.new(new_hand, 5000)
    end
  end

  private

  def new_hand
    cards = []
    5.times { cards << @deck.deal_card }
    Hand.new_full_hand(cards)
  end
end
