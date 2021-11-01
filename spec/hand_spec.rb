require 'rspec'
require 'hand'

describe Hand do
  subject { Hand.new }

  describe '::new_full_hand' do
    subject(:full_hand) do
      Hand.new_full_hand([
                           Card.new(:spade, :A),
                           Card.new(:spade, :two),
                           Card.new(:spade, :three),
                           Card.new(:spade, :four),
                           Card.new(:spade, :five)
                         ])
    end

    it 'returns a new hand' do
      expect(subject).to be_a(Hand)
    end

    it 'adds the cards' do
      expect(subject.cards.length).to eq(5)
    end

    it 'raises an error if 5 cards aren\'t passed in' do
      expect { Hand.new_full_hand([Card.new(:spade, :two)]) }.to raise_error ArgumentError
    end
  end

  describe '#initialize' do
    it 'starts with no cards' do
      expect(subject.cards).to be_empty
    end
  end

  describe '#add_card' do
    let(:card) { double('4 ♥', is_a?: true) }

    it 'raises an error if a non-Card is passed' do
      expect { subject.add_card('spade') }.to raise_error ArgumentError, 'Not a card.'
    end

    context 'when hand is not full' do
      it 'appends a card to @cards' do
        subject.add_card(card)
        expect(subject.cards).to include(card)
      end
    end

    context 'when hand is full' do
      subject { Hand.new_full_hand([card, card, card, card, card]) }

      it 'raises an error' do
        expect { subject.add_card(card) }.to raise_error ArgumentError, 'Hand is full.'
      end
    end
  end

  describe '#replace_card' do
    let(:card1) { double('card1', is_a?: true) }
    let(:card2) { double('card2', is_a?: true) }
    let(:card3) { double('card3', is_a?: true) }
    let(:card4) { double('card4', is_a?: true) }
    let(:card5) { double('card5', is_a?: true) }
    let(:new_card) { double('card6', is_a?: true) }

    subject { Hand.new_full_hand([card1, card2, card3, card4, card5]) }

    context 'when a correct index is given' do
      it 'removes the card at that index' do
        expect(subject.cards).to include(card2)
        subject.replace_card(1, new_card)
        expect(subject.cards).to_not include(card2)
      end

      it 'adds a new card' do
        expect(subject.cards).to_not include(new_card)
        subject.replace_card(1, new_card)
        expect(subject.cards).to include(new_card)
      end
    end

    context 'when an incorrect index is given' do
      it 'raises an error' do
        expect { subject.replace_card(5, new_card) }.to raise_error ArgumentError, 'Index out of bounds.'
        expect { subject.replace_card(-6, new_card) }.to raise_error ArgumentError, 'Index out of bounds.'
      end

      it 'does not change the cards' do
        expect(subject.cards).to match_array [card1, card2, card3, card4, card5]
        expect { subject.replace_card(-6, new_card) }.to raise_error ArgumentError, 'Index out of bounds.'
        expect(subject.cards).to match_array [card1, card2, card3, card4, card5]
      end
    end
  end

  let(:royal_flush) do
    Hand.new_full_hand([
      Card.new(:spade, :A),
      Card.new(:spade, :K),
      Card.new(:spade, :Q),
      Card.new(:spade, :J),
      Card.new(:spade, :ten)
    ])
  end

  let(:straight_flush) do
    Hand.new_full_hand([
      Card.new(:spade, :eight),
      Card.new(:spade, :five),
      Card.new(:spade, :seven),
      Card.new(:spade, :six),
      Card.new(:spade, :four)
    ])
  end

  let(:straight_flush_ace_low) do
    Hand.new_full_hand([
      Card.new(:spade, :A),
      Card.new(:spade, :two),
      Card.new(:spade, :three),
      Card.new(:spade, :four),
      Card.new(:spade, :five)
    ])
  end

  let(:four_of_a_kind) do
    Hand.new_full_hand([
      Card.new(:club, :three),
      Card.new(:spade, :A),
      Card.new(:diamond, :A),
      Card.new(:heart, :A),
      Card.new(:club, :A)
    ])
  end

  let(:full_house) do
    Hand.new_full_hand([
      Card.new(:club, :ten),
      Card.new(:spade, :ten),
      Card.new(:diamond, :ten),
      Card.new(:heart, :nine),
      Card.new(:club, :nine)
    ])
  end

  let(:flush) do
    Hand.new_full_hand([
      Card.new(:heart, :four),
      Card.new(:heart, :J),
      Card.new(:heart, :eight),
      Card.new(:heart, :two),
      Card.new(:heart, :nine)
    ])
  end

  let(:straight) do
    Hand.new_full_hand([
      Card.new(:spade, :six),
      Card.new(:spade, :two),
      Card.new(:spade, :three),
      Card.new(:spade, :four),
      Card.new(:club, :five)
    ])
  end

  let(:straight_ace_low) do
    Hand.new_full_hand([
      Card.new(:spade, :A),
      Card.new(:spade, :two),
      Card.new(:spade, :three),
      Card.new(:spade, :four),
      Card.new(:club, :five)
    ])
  end

  let(:straight_ace_high) do
    Hand.new_full_hand([
      Card.new(:spade, :A),
      Card.new(:spade, :K),
      Card.new(:spade, :Q),
      Card.new(:spade, :J),
      Card.new(:club, :ten)
    ])
  end

  let(:three_of_a_kind) do
    Hand.new_full_hand([
      Card.new(:spade, :seven),
      Card.new(:club, :seven),
      Card.new(:diamond, :seven),
      Card.new(:spade, :J),
      Card.new(:club, :three)
    ])
  end

  let(:two_pair) do
    Hand.new_full_hand([
      Card.new(:spade, :four),
      Card.new(:club, :four),
      Card.new(:diamond, :three),
      Card.new(:spade, :three),
      Card.new(:club, :Q)
    ])
  end

  let(:pair) do
    Hand.new_full_hand([
      Card.new(:spade, :A),
      Card.new(:club, :A),
      Card.new(:diamond, :two),
      Card.new(:spade, :four),
      Card.new(:club, :seven)
    ])
  end

  let(:high_card) do
    Hand.new_full_hand([
      Card.new(:spade, :three),
      Card.new(:club, :J),
      Card.new(:diamond, :eight),
      Card.new(:spade, :four),
      Card.new(:club, :two)
    ])
  end

  let(:number_high_card) do
      Hand.new_full_hand([
        Card.new(:spade, :three),
        Card.new(:club, :five),
        Card.new(:diamond, :eight),
        Card.new(:spade, :four),
        Card.new(:club, :two)
      ])
    end

  let(:face_high_card) do
    Hand.new_full_hand([
      Card.new(:spade, :three),
      Card.new(:club, :J),
      Card.new(:diamond, :eight),
      Card.new(:spade, :four),
      Card.new(:club, :two)
    ])
  end

  let(:ace_high_card) do
    Hand.new_full_hand([
      Card.new(:spade, :three),
      Card.new(:club, :J),
      Card.new(:diamond, :eight),
      Card.new(:spade, :A),
      Card.new(:club, :two)
    ])
  end

  describe '#type' do
    it 'identifies Royal Flush' do
      expect(royal_flush.type).to be(:royal_flush)
    end

    context 'Straight flush' do
      it 'identified correctly' do
        expect(straight_flush.type).to be(:straight_flush)
      end

      it 'with Ace low identified correclty' do
        expect(straight_flush_ace_low.type).to be(:straight_flush)
      end
    end

    it 'identifies Four of a Kind' do
      expect(four_of_a_kind.type).to be(:four_of_a_kind)
    end

    it 'identifies Full House' do
      expect(full_house.type).to be(:full_house)
    end

    it 'identifies Flush' do
      expect(flush.type).to be(:flush)
    end

    it 'identifies Straight' do
      expect(straight.type).to be(:straight)
    end

    it 'identifies Straight with Ace low' do
      expect(straight_ace_low.type).to be(:straight)
    end

    it 'identifies Straight with Ace high' do
      expect(straight_ace_high.type).to be(:straight)
    end

    it 'identifies Three of a Kind' do
      expect(three_of_a_kind.type).to be(:three_of_a_kind)
    end

    it 'identifies Two Pair' do
      expect(two_pair.type).to be(:two_pair)
    end

    it 'identifies Pair' do
      expect(pair.type).to be(:pair)
    end

    it 'identifies High Card' do
      expect(high_card.type).to be(:high_card)
    end
  end

  describe '#highest_card' do
    it 'identifies highest number card' do
      expect(number_high_card.highest_card).to eq(Card.new(:diamond, :eight))
    end

    it 'identifies face card higher than number card' do
      expect(face_high_card.highest_card).to eq(Card.new(:club, :J))
    end

    it 'identifies High Card with Ace' do
      expect(ace_high_card.highest_card).to eq(Card.new(:spade, :A))
    end
  end

  describe '#<=>(other_hand)' do
  

    it 'returns -1 if less than other_hand' do
      expect(ace_high_card <=> royal_flush).to eq(-1)
      expect(straight_flush <=> royal_flush).to eq(-1)
      expect(four_of_a_kind <=> straight_flush).to eq(-1)
    end

    it 'returns 0 if equal to other_hand' do
      hand = Hand.new_full_hand([
        Card.new(:club, :three),
        Card.new(:spade, :K),
        Card.new(:diamond, :K),
        Card.new(:heart, :K),
        Card.new(:club, :K)
      ])
      expect(hand <=> four_of_a_kind).to eq(0)
    end

    it 'returns 1 if greater than to other_hand' do
      expect(royal_flush <=> ace_high_card).to eq(1)
      expect(straight_flush <=> four_of_a_kind).to eq(1)
      expect(two_pair <=> pair).to eq(1)
    end

    it 'correctly compares high cards' do
      expect(number_high_card <=> face_high_card).to eq(-1)
      expect(face_high_card <=> ace_high_card).to eq(-1)
      expect(ace_high_card <=> number_high_card).to eq(1)
    end
  end
end
