module CardConstants
  RANKS = ['A', 2, 3, 4, 5, 6, 7, 8, 9, 10, 'J', 'Q', 'K'].freeze

  SUITS = [
    Suit.new('spade'),
    Suit.new('diamond'),
    Suit.new('club'),
    Suit.new('heart')
  ].freeze

  HAND_RANKINGS = %i[
    high_card
    pair
    two_pair
    three_of_a_kind
    straight
    flush
    full_house
    four_of_a_kind
    straight_flush
    royal_flush
  ].freeze
end
