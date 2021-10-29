require 'rspec'
require 'card'

describe Card do
  # let(:suit) { Suit.new('spade') }
  let(:suit) { double('spade', name: 'spade', is_a?: true, inspect: '♠'.black, color: :black) }
  subject { Card.new(suit, 7) }

  describe '#initialize' do
    it 'accepts a suit and a rank' do
      expect { Card.new(suit, 5) }.to_not raise_error
    end

    it 'does not accept an incorrect rank argument' do
      expect { Card.new(suit, 0) }.to raise_error ArgumentError, 'Incorrect rank.'
      expect { Card.new(suit, 11) }.to raise_error ArgumentError, 'Incorrect rank.'
      expect { Card.new(suit, 1) }.to raise_error ArgumentError, 'Incorrect rank.'
      expect { Card.new(suit, 'B') }.to raise_error ArgumentError, 'Incorrect rank.'
    end

    it 'does not accept an incorrect suit argument' do
      expect { Card.new('club', 4) }.to raise_error ArgumentError, 'Incorrect suit.'
    end
  end

  describe '#rank' do
    it 'returns the rank' do
      expect(subject.rank).to eq(7)
    end
  end

  describe '#suit' do
    it 'returns the suit' do
      expect(subject.suit).to eq(suit)
    end
  end

  describe '#inspect' do
    it 'returns an understandable representation of the card' do
      expect(subject.inspect.uncolorize).to eq('<7 ♠>'.uncolorize)
    end
  end

  describe '#==' do
    let(:four_of_clubs1) { Card.new(Suit.new('club'), 4) }
    let(:four_of_clubs2) { Card.new(Suit.new('club'), 4) }
    let(:five_of_clubs) { Card.new(Suit.new('club'), 5) }
    let(:five_of_spades) { Card.new(Suit.new('spade'), 5) }

    it 'passes for two cards with same suit and rank' do
      expect(four_of_clubs1).to eq(four_of_clubs2)
    end

    it 'doesn\'t pass for two cards with same suit and different rank' do
      expect(four_of_clubs1).to_not eq(five_of_clubs)
    end

    it 'doesn\'t pass for two cards with different suits and same rank' do
      expect(five_of_clubs).to_not eq(five_of_spades)
    end
  end

  describe '#<=>' do
    let(:ace_of_spades) { Card.new(Suit.new('spade'), 'A') }
    let(:ace_of_diamonds) { Card.new(Suit.new('diamond'), 'A') }
    let(:ace_of_clubs) { Card.new(Suit.new('club'), 'A') }
    let(:ace_of_hearts) { Card.new(Suit.new('heart'), 'A') }
    let(:king_of_spades) { Card.new(Suit.new('spade'), 'K') }
    let(:queen_of_spades) { Card.new(Suit.new('spade'), 'Q') }
    let(:two_of_spades) { Card.new(Suit.new('spade'), 2) }
    it 'compares cards by rank (spade < diamond < club < heart)' do
      expect(ace_of_spades <=> ace_of_diamonds).to eq(-1)
      expect(ace_of_diamonds <=> ace_of_clubs).to eq(-1)
      expect(ace_of_clubs <=> ace_of_hearts).to eq(-1)
      expect(ace_of_hearts <=> ace_of_spades).to eq(1)
      expect(ace_of_clubs <=> ace_of_diamonds).to eq(1)
    end

    it 'compares cards by rank (Ace is low)' do
      expect(ace_of_spades <=> king_of_spades).to eq(-1)
      expect(ace_of_spades <=> two_of_spades).to eq(-1)
      expect(two_of_spades <=> ace_of_spades).to eq(1)
      expect(king_of_spades <=> ace_of_spades).to eq(1)
      expect(king_of_spades <=> queen_of_spades).to eq(1)
    end

    it 'returns 0 for cards of equal suit and rank' do
      expect(two_of_spades <=> Card.new(Suit.new('spade'), 2)).to eq(0)
    end
  end
end
