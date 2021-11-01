require_relative 'deck'

class Player
  attr_reader :hand, :chips, :folded

  def initialize(hand, chips)
    @hand = hand
    @chips = chips
    @folded = false
  end

  def bet(bet_amount)
    raise(ArgumentError, 'Not enough chips!') unless @chips >= bet_amount

    @chips -= bet_amount
  end

  def fold
    @folded = true
  end

  def reset_round
    @folded = false
  end

  def handle_action(action_and_amount)
    # debugger
    action, amount = action_and_amount
    case action
    when :bet
      bet(amount)
    when :raise
      bet(amount)
    when :fold
      fold
    end
  end

  def replace_cards(indices, new_cards)
    indices.each_with_index do |hand_index, new_cards_index|
      @hand.replace_card(hand_index, new_cards[new_cards_index])
    end
  end
end
