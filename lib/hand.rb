require_relative 'card'
require_relative 'card_constants'

class Hand
  include CardConstants

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

  def type
    return :royal_flush if royal_flush?

    return :straight_flush if straight_flush?

    return :four_of_a_kind if four_of_a_kind?

    return :full_house if full_house?

    return :flush if flush?

    return :straight if straight?(rank_indices) || straight?(rank_indices(ace_high: true))

    return :three_of_a_kind if three_of_a_kind?

    return :two_pair if two_pair?

    return :pair if pair?

    :high_card
  end

  def highest_card
    card_values = rank_indices(ace_high: true)
    max_card_value = card_values.max
    index_of_max_card = card_values.index(max_card_value)
    @cards[index_of_max_card]
  end

  def <=>(other)
    my_type = type
    other_type = other.type
    my_ranking = HAND_RANKINGS.index(my_type)
    other_ranking = HAND_RANKINGS.index(other_type)

    if my_type == :high_card && other_type == :high_card
      my_ranking = rank_index(highest_card, ace_high: true)
      other_ranking = rank_index(other.highest_card, ace_high: true)
    end

    my_ranking <=> other_ranking
  end

  private

  def royal_flush?
    return false unless flush?

    required_ranks = %w[A K Q J 10]
    ranks.map(&:to_s).sort == required_ranks.map(&:to_s).sort
  end

  def straight_flush?
    return false unless all_same_suit?

    straight?(rank_indices) || straight?(rank_indices(ace_high: true))
  end

  def straight?(rank_indices)
    sorted_rank_indices = rank_indices.sort
    (0...4).each do |index|
      rank1 = sorted_rank_indices[index]
      rank2 = sorted_rank_indices[index + 1]
      return false unless (rank2 - rank1) == 1
    end
    true
  end

  def four_of_a_kind?
    n_of_a_kind?(4).length.positive?
  end

  def full_house?
    three_of_a_kind? && pair?
  end

  def flush?
    all_same_suit?
  end

  def three_of_a_kind?
    n_of_a_kind?(3).length.positive?
  end

  def two_pair?
    n_of_a_kind?(2).length == 2
  end

  def pair?
    n_of_a_kind?(2).length.positive?
  end

  def rank_counts
    rank_counts = Hash.new(0)
    RANKS.each do |rank|
      rank_counts[rank] += ranks.count { |card_rank| card_rank == rank }
    end
    rank_counts
  end

  def n_of_a_kind?(n)
    matches = []
    rank_counts.each do |rank, count|
      matches << rank if count == n
    end
    matches
  end

  def rank_indices(ace_high: false)
    if ace_high
      rank_indices_ace_high
    else
      rank_indices_ace_low
    end
  end

  def rank_indices_ace_low
    @cards.map { |card| rank_index(card) }
  end

  def rank_indices_ace_high
    @cards.map do |card|
      if card.rank == 'A'
        high_ace_rank(card)
      else
        rank_index(card)
      end
    end
  end

  def all_same_suit?
    suits.uniq.length == 1
  end

  def suits
    @cards.map(&:suit)
  end

  def ranks
    @cards.map(&:rank)
  end

  def rank_index(card, ace_high: false)
    return 13 if ace_high && card.rank == 'A'

    RANKS.index(card.rank)
  end

  def high_ace_rank(card)
    raise ArgumentError, 'Not an Ace' unless card.rank == 'A'

    high_ace = {
      'spade' => 13,
      'diamond' => 26,
      'club' => 39,
      'heart' => 52
    }

    high_ace[card.suit.name]
  end
end
