module CardConstants
  RANKS = ['A', 2, 3, 4, 5, 6, 7, 8, 9, 10, 'J', 'Q', 'K'].freeze
  SUITS = [
    Suit.new('spade'),
    Suit.new('diamond'),
    Suit.new('club'),
    Suit.new('heart')
  ].freeze
end
