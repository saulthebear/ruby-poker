require_relative 'card'

class Hand
  attr_reader :cards

  def initialize
    @cards = []
  end

  def add_card(card)
    raise ArgumentError, 'Not a card.' unless card.is_a?(Card)
    raise ArgumentError, 'Hand is full.' if @cards.length > 4

    @cards << card
  end

  def replace_card(index, new_card)
    raise ArgumentError, 'Index out of bounds.' if index.abs > @cards.length - 1
    raise ArgumentError, 'Not a card.' unless new_card.is_a?(Card)

    @cards[index] = new_card
  end
end
