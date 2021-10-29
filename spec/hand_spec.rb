require 'rspec'
require 'hand'

describe Hand do
  subject = Hand.new
  let(:spade) { Suit.new('spade') }
  let(:club) { Suit.new('club') }
  let(:heart) { Suit.new('heart') }
  let(:diamond) { Suit.new('diamond') }

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
      before(:each) do
        subject = Hand.new
        subject.add_card(card)
        subject.add_card(card)
        subject.add_card(card)
        subject.add_card(card)
        subject.add_card(card)
      end
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

    before(:each) do
      subject = Hand.new
      subject.add_card(card1)
      subject.add_card(card2)
      subject.add_card(card3)
      subject.add_card(card4)
      subject.add_card(card5)
    end
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

  describe '#type' do
    it 'identifies Royal Flush' do
      hand = Hand.new
      hand.add_card(Card.new(spade, 'A'))
      hand.add_card(Card.new(spade, 'K'))
      hand.add_card(Card.new(spade, 'Q'))
      hand.add_card(Card.new(spade, 'J'))
      hand.add_card(Card.new(spade, 10))
      expect(hand.type).to be(:royal_flush)
    end

    context 'Straight flush' do
      it 'identified correctly' do
        hand = Hand.new
        hand.add_card(Card.new(spade, 8))
        hand.add_card(Card.new(spade, 5))
        hand.add_card(Card.new(spade, 7))
        hand.add_card(Card.new(spade, 6))
        hand.add_card(Card.new(spade, 4))
        expect(hand.type).to be(:straight_flush)
      end

      it 'with Ace low identified correclty' do
        hand = Hand.new
        hand.add_card(Card.new(spade, 'A'))
        hand.add_card(Card.new(spade, 2))
        hand.add_card(Card.new(spade, 3))
        hand.add_card(Card.new(spade, 4))
        hand.add_card(Card.new(spade, 5))
        expect(hand.type).to be(:straight_flush)
      end
    end

    context 'Four of a Kind' do
      it 'identified correclty - 4 Aces' do
        hand = Hand.new
        hand.add_card(Card.new(club, 3))
        hand.add_card(Card.new(spade, 'A'))
        hand.add_card(Card.new(diamond, 'A'))
        hand.add_card(Card.new(heart, 'A'))
        hand.add_card(Card.new(club, 'A'))
        expect(hand.type).to be(:four_of_a_kind)
      end

      it 'identified correclty - 4 Kings' do
        hand = Hand.new
        hand.add_card(Card.new(club, 3))
        hand.add_card(Card.new(spade, 'K'))
        hand.add_card(Card.new(diamond, 'K'))
        hand.add_card(Card.new(heart, 'K'))
        hand.add_card(Card.new(club, 'K'))
        expect(hand.type).to be(:four_of_a_kind)
      end

      it 'identified correclty - 4 Fours' do
        hand = Hand.new
        hand.add_card(Card.new(club, 3))
        hand.add_card(Card.new(spade, 4))
        hand.add_card(Card.new(diamond, 4))
        hand.add_card(Card.new(heart, 4))
        hand.add_card(Card.new(club, 4))
        expect(hand.type).to be(:four_of_a_kind)
      end
    end

    it 'identifies Full House' do
      hand = Hand.new
      hand.add_card(Card.new(diamond, 10))
      hand.add_card(Card.new(heart, 10))
      hand.add_card(Card.new(club, 10))
      hand.add_card(Card.new(spade, 9))
      hand.add_card(Card.new(diamond, 9))
      expect(hand.type).to be(:full_house)
    end

    it 'identifies Flush' do
      hand = Hand.new
      hand.add_card(Card.new(heart, 4))
      hand.add_card(Card.new(heart, 'J'))
      hand.add_card(Card.new(heart, 8))
      hand.add_card(Card.new(heart, 2))
      hand.add_card(Card.new(heart, 9))
      expect(hand.type).to be(:flush)
    end

    it 'identifies Straight' do
      hand = Hand.new
      hand.add_card(Card.new(spade, 6))
      hand.add_card(Card.new(spade, 2))
      hand.add_card(Card.new(spade, 3))
      hand.add_card(Card.new(spade, 4))
      hand.add_card(Card.new(club, 5))
      expect(hand.type).to be(:straight)
    end

    it 'identifies Straight with Ace low' do
      hand = Hand.new
      hand.add_card(Card.new(spade, 'A'))
      hand.add_card(Card.new(spade, 2))
      hand.add_card(Card.new(spade, 3))
      hand.add_card(Card.new(spade, 4))
      hand.add_card(Card.new(club, 5))
      expect(hand.type).to be(:straight)
    end

    it 'identifies Straight with Ace high' do
      hand = Hand.new
      hand.add_card(Card.new(spade, 'A'))
      hand.add_card(Card.new(club, 'K'))
      hand.add_card(Card.new(spade, 'Q'))
      hand.add_card(Card.new(spade, 'J'))
      hand.add_card(Card.new(spade, 10))
      expect(hand.type).to be(:straight)
    end

    it 'identifies Three of a Kind' do
      hand = Hand.new
      hand.add_card(Card.new(club, 7))
      hand.add_card(Card.new(diamond, 7))
      hand.add_card(Card.new(spade, 7))
      hand.add_card(Card.new(club, 'K'))
      hand.add_card(Card.new(diamond, 3))
      expect(hand.type).to be(:three_of_a_kind)
    end

    it 'identifies Two Pair' do
      hand = Hand.new
      hand.add_card(Card.new(spade, 4))
      hand.add_card(Card.new(club, 4))
      hand.add_card(Card.new(club, 3))
      hand.add_card(Card.new(diamond, 3))
      hand.add_card(Card.new(club, 'Q'))
      expect(hand.type).to be(:two_pair)
    end

    it 'identifies Pair' do
      hand = Hand.new
      hand.add_card(Card.new(heart, 'A'))
      hand.add_card(Card.new(diamond, 'A'))
      hand.add_card(Card.new(club, 8))
      hand.add_card(Card.new(spade, 4))
      hand.add_card(Card.new(heart, 7))
      expect(hand.type).to be(:pair)
    end

    it 'identifies High Card' do
      hand = Hand.new
      hand.add_card(Card.new(diamond, 3))
      hand.add_card(Card.new(club, 'J'))
      hand.add_card(Card.new(spade, 8))
      hand.add_card(Card.new(heart, 4))
      hand.add_card(Card.new(spade, 2))
      expect(hand.type).to be(:high_card)
    end
  end

  describe '#highest_card' do
    it 'identifies highest number card' do
      hand = Hand.new
      hand.add_card(Card.new(diamond, 3))
      hand.add_card(Card.new(club, 5))
      hand.add_card(Card.new(spade, 8))
      hand.add_card(Card.new(spade, 2))
      hand.add_card(Card.new(spade, 4))
      expect(hand.highest_card).to eq(Card.new(spade, 8))
    end

    it 'identifies face card higher than number card' do
      hand = Hand.new
      hand.add_card(Card.new(diamond, 3))
      hand.add_card(Card.new(club, 'J'))
      hand.add_card(Card.new(spade, 8))
      hand.add_card(Card.new(spade, 4))
      hand.add_card(Card.new(spade, 2))
      expect(hand.highest_card).to eq(Card.new(club, 'J'))
    end

    it 'identifies highest face card' do
      hand = Hand.new
      hand.add_card(Card.new(diamond, 3))
      hand.add_card(Card.new(club, 'J'))
      hand.add_card(Card.new(spade, 8))
      hand.add_card(Card.new(spade, 'K'))
      hand.add_card(Card.new(spade, 2))
      expect(hand.highest_card).to eq(Card.new(spade, 'K'))
    end

    it 'identifies High Card with Ace' do
      hand = Hand.new
      hand.add_card(Card.new(diamond, 3))
      hand.add_card(Card.new(club, 'J'))
      hand.add_card(Card.new(spade, 8))
      hand.add_card(Card.new(spade, 'A'))
      hand.add_card(Card.new(spade, 2))
      expect(hand.highest_card).to eq(Card.new(spade, 'A'))
    end
  end

  describe '#<=>(other_hand)' do
    let(:royal_flush) do
      hand = Hand.new
      hand.add_card(Card.new(spade, 'A'))
      hand.add_card(Card.new(spade, 'K'))
      hand.add_card(Card.new(spade, 'Q'))
      hand.add_card(Card.new(spade, 'J'))
      hand.add_card(Card.new(spade, 10))
      hand
    end

    let(:straight_flush) do
      hand = Hand.new
      hand.add_card(Card.new(spade, 8))
      hand.add_card(Card.new(spade, 5))
      hand.add_card(Card.new(spade, 7))
      hand.add_card(Card.new(spade, 6))
      hand.add_card(Card.new(spade, 4))
      hand
    end

    let(:four_of_a_kind) do
      hand = Hand.new
      hand.add_card(Card.new(club, 3))
      hand.add_card(Card.new(spade, 'A'))
      hand.add_card(Card.new(diamond, 'A'))
      hand.add_card(Card.new(heart, 'A'))
      hand.add_card(Card.new(club, 'A'))
      hand
    end

    let(:full_house) do
      hand = Hand.new
      hand.add_card(Card.new(diamond, 10))
      hand.add_card(Card.new(heart, 10))
      hand.add_card(Card.new(club, 10))
      hand.add_card(Card.new(spade, 9))
      hand.add_card(Card.new(diamond, 9))
      hand
    end

    let(:flush) do
      hand = Hand.new
      hand.add_card(Card.new(heart, 4))
      hand.add_card(Card.new(heart, 'J'))
      hand.add_card(Card.new(heart, 8))
      hand.add_card(Card.new(heart, 2))
      hand.add_card(Card.new(heart, 9))
      hand
    end

    let(:straight) do
      hand = Hand.new
      hand.add_card(Card.new(spade, 6))
      hand.add_card(Card.new(spade, 2))
      hand.add_card(Card.new(spade, 3))
      hand.add_card(Card.new(spade, 4))
      hand.add_card(Card.new(club, 5))
      hand
    end

    let(:three_of_a_kind) do
      hand = Hand.new
      hand.add_card(Card.new(club, 7))
      hand.add_card(Card.new(diamond, 7))
      hand.add_card(Card.new(spade, 7))
      hand.add_card(Card.new(club, 'K'))
      hand.add_card(Card.new(diamond, 3))
      hand
    end

    let(:two_pair) do
      hand = Hand.new
      hand.add_card(Card.new(spade, 4))
      hand.add_card(Card.new(club, 4))
      hand.add_card(Card.new(club, 3))
      hand.add_card(Card.new(diamond, 3))
      hand.add_card(Card.new(club, 'Q'))
      hand
    end

    let(:pair) do
      hand = Hand.new
      hand.add_card(Card.new(heart, 'A'))
      hand.add_card(Card.new(diamond, 'A'))
      hand.add_card(Card.new(club, 8))
      hand.add_card(Card.new(spade, 4))
      hand.add_card(Card.new(heart, 7))
      hand
    end

    let(:eight_high) do
      hand = Hand.new
      hand.add_card(Card.new(diamond, 3))
      hand.add_card(Card.new(club, 5))
      hand.add_card(Card.new(spade, 8))
      hand.add_card(Card.new(spade, 2))
      hand.add_card(Card.new(spade, 4))
      hand
    end

    let(:jack_high) do
      hand = Hand.new
      hand.add_card(Card.new(diamond, 3))
      hand.add_card(Card.new(club, 'J'))
      hand.add_card(Card.new(spade, 8))
      hand.add_card(Card.new(spade, 4))
      hand.add_card(Card.new(spade, 2))
      hand
    end

    let(:ace_high) do
      hand = Hand.new
      hand.add_card(Card.new(diamond, 3))
      hand.add_card(Card.new(club, 'J'))
      hand.add_card(Card.new(spade, 8))
      hand.add_card(Card.new(spade, 'A'))
      hand.add_card(Card.new(spade, 2))
      hand
    end

    it 'returns -1 if less than other_hand' do
      expect(ace_high <=> royal_flush).to eq(-1)
      expect(straight_flush <=> royal_flush).to eq(-1)
      expect(four_of_a_kind <=> straight_flush).to eq(-1)
    end

    it 'returns 0 if equal to other_hand' do
      hand = Hand.new
      hand.add_card(Card.new(club, 3))
      hand.add_card(Card.new(spade, 'K'))
      hand.add_card(Card.new(diamond, 'K'))
      hand.add_card(Card.new(heart, 'K'))
      hand.add_card(Card.new(club, 'K'))

      expect(hand <=> four_of_a_kind).to eq(0)
    end

    it 'returns 1 if greater than to other_hand' do
      expect(royal_flush <=> ace_high).to eq(1)
      expect(straight_flush <=> four_of_a_kind).to eq(1)
      expect(two_pair <=> pair).to eq(1)
    end

    it 'correctly compares high cards' do
      expect(eight_high <=> jack_high).to eq(-1)
      expect(jack_high <=> ace_high).to eq(-1)
      expect(ace_high <=> eight_high).to eq(1)
    end
  end
end
