module CardConstants
  RANKS = %i[A two three four five six seven eight nine ten J Q K].freeze
  RANK_STRINGS = %w[A 2 3 4 5 6 7 8 9 10 J Q K].freeze

  SUITS = %i[spade diamond club heart].freeze
  SUIT_STRINGS = %w[♠ ♦ ♣ ♥].freeze

  COLORS = {
    spade: :light_black,
    heart: :red,
    diamond: :red,
    club: :light_black
  }.freeze

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
