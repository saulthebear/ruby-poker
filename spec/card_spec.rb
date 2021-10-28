require 'rspec'
require 'card'

describe Card do
  # let(:suit) { Suit.new('spade') }
  let(:suit) { double('spade', is_a?: true, inspect: '♠'.black, color: :black) }
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
end
