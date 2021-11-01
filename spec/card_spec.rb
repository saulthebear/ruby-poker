require 'rspec'
require 'card'

describe Card do
  subject { Card.new(:spade, :seven) }

  describe '#initialize' do
    it 'accepts a suit and a rank' do
      expect { Card.new(:spade, :five) }.to_not raise_error
    end

    it 'does not accept an incorrect rank argument' do
      expect { Card.new(:spade, :one) }.to raise_error ArgumentError, 'Incorrect rank.'
    end

    it 'does not accept an incorrect suit argument' do
      expect { Card.new(:triangle, :four) }.to raise_error ArgumentError, 'Incorrect suit.'
    end
  end

  describe '#rank' do
    it 'returns the rank' do
      expect(subject.rank).to eq(:seven)
    end
  end

  describe '#suit' do
    it 'returns the suit' do
      expect(subject.suit).to eq(:spade)
    end
  end

  describe '#inspect' do
    it 'returns an understandable representation of the card' do
      expect(subject.inspect.uncolorize).to eq('<7 ♠>'.uncolorize)
    end
  end

  describe '#==' do
    let(:four_of_clubs1) { Card.new(:club, :four) }
    let(:four_of_clubs2) { Card.new(:club, :four) }
    let(:five_of_clubs) { Card.new(:club, :five) }
    let(:five_of_spades) { Card.new(:spade, :five) }

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
    let(:ace_of_spades) { Card.new(:spade, :A) }
    let(:ace_of_diamonds) { Card.new(:diamond, :A) }
    let(:ace_of_clubs) { Card.new(:club, :A) }
    let(:ace_of_hearts) { Card.new(:heart, :A) }
    let(:king_of_spades) { Card.new(:spade, :K) }
    let(:queen_of_spades) { Card.new(:spade, :Q) }
    let(:two_of_spades) { Card.new(:spade, :two) }
    it 'compares cards by suit (spade < diamond < club < heart)' do
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
      expect(two_of_spades <=> Card.new(:spade, :two)).to eq(0)
    end
  end
end
