# require 'byebug'
require 'rspec'
require 'player'

describe Player do
  let(:card1) { Card.new(:spade, :four) }
  let(:card2) { Card.new(:spade, :five) }
  let(:card3) { Card.new(:spade, :six) }
  let(:card4) { Card.new(:spade, :seven) }
  let(:card5) { Card.new(:spade, :eight) }
  let(:hand) do
    hand = Hand.new_full_hand([card1, card2, card3, card4, card5])
    hand
  end
  subject { Player.new(hand, 5000) }

  describe '#initialize' do
    it 'should start with 5 cards in hand' do
      subject_hand = subject.hand.cards
      expect(subject_hand.length).to eq(5)
    end

    it 'should set the player\'s chips' do
      expect(subject.chips).to eq(5000)
    end
  end

  describe '#bet' do
    it 'should subtract the bet amount from the player\'s chips' do
      expect { subject.bet(5) }.to change { subject.chips }.by(-5)
    end

    it 'should raise an error if the amount is greater than the player\'s chips' do
      expect { subject.bet(6000) }.to raise_error(ArgumentError, 'Not enough chips!')
    end
  end

  describe '#fold' do
    it 'should set @folded to true' do
      expect(subject.folded).to be(false)
      subject.fold
      expect(subject.folded).to be(true)
    end
  end

  describe '#new_round' do
    it 'should set @folded to false' do
      subject.fold
      expect(subject.folded).to be(true)
      subject.reset_round
      expect(subject.folded).to be(false)
    end
  end

  describe '#handle_action' do
    it 'should handle bet' do
      expect(subject).to receive(:bet).with(50)
      subject.handle_action([:bet, 50])
    end

    it 'should handle raise' do
      expect(subject).to receive(:bet).with(20)
      subject.handle_action([:raise, 20])
    end

    it 'should handle fold' do
      expect(subject).to receive(:fold)
      subject.handle_action(:fold)
    end
  end

  describe '#replace_cards' do
    let(:new_cards) { [Card.new(:spade, :J), Card.new(:spade, :K)] }

    it 'should remove the correct cards' do
      expect(subject.hand.cards).to include(card1)
      expect(subject.hand.cards).to include(card2)
      subject.replace_cards([0, 1], new_cards)
      expect(subject.hand.cards).to_not include(card1)
      expect(subject.hand.cards).to_not include(card2)
    end

    it 'should leave the player with 5 cards' do
      expect(subject.hand.cards.length).to be(5)
      subject.replace_cards([0, 1], new_cards)
      expect(subject.hand.cards.length).to be(5)
    end
  end

  describe '#new_hand' do
    let(:new_hand) do
      Hand.new_full_hand([
        Card.new(:diamond, :A),
        Card.new(:club, :J),
        Card.new(:spade, :Q),
        Card.new(:heart, :two),
        Card.new(:club, :nine)
        ])
    end

    it 'changes the player\'s hand' do
      old_cards = subject.hand.cards
      subject.new_hand(new_hand)
      expect(old_cards).to_not match_array(subject.hand.cards)
    end

    it 'returns the old cards' do
      old_cards = subject.hand.cards
      expect(subject.new_hand(new_hand)).to match_array(old_cards)
    end
  end
end
