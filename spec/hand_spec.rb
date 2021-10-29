require 'rspec'
require 'hand'

describe Hand do
  subject = Hand.new
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
    it 'identifies Royal Flush'
    it 'identifies Straight Flush'
    it 'identifies Four of a Kind'
    it 'identifies Full House'
    it 'identifies Flush'
    it 'identifies Straight'
    it 'identifies Three of a Kind'
    it 'identifies Two Pair'
    it 'identifies Pair'
    it 'identifies High Card'
  end

  describe '#<=>(other_hand)' do
    it 'returns -1 if less than other_hand'
    it 'returns 0 if equal to other_hand'
    it 'returns 1 if greater than to other_hand'
  end
end
