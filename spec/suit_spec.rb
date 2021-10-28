require 'rspec'
require 'suit'

describe Suit do
  describe '#initialize' do
    it 'accepts suit name' do
      expect { Suit.new('spade') }.to_not raise_error
    end

    it 'doesn\'t accept non-suit name' do
      expect { Suit.new('') }.to raise_error ArgumentError, 'Incorrect suit name.'
      expect { Suit.new('ace') }.to raise_error ArgumentError, 'Incorrect suit name.'
    end

    it 'sets the correct color' do
      expect(Suit.new('spade').color).to be(:light_black)
      expect(Suit.new('heart').color).to be(:red)
      expect(Suit.new('diamond').color).to be(:red)
      expect(Suit.new('club').color).to be(:light_black)
    end

    it 'sets the correct symbol' do
      expect(Suit.new('spade').symbol).to eq('♠')
      expect(Suit.new('heart').symbol).to eq('♥')
      expect(Suit.new('diamond').symbol).to eq('♦')
      expect(Suit.new('club').symbol).to eq('♣')
    end
  end

  it 'prints a colorized string' do
    expect(Suit.new('spade').to_s).to eq('♠'.light_black)
    expect(Suit.new('heart').to_s).to eq('♥'.red)
    expect(Suit.new('diamond').to_s).to eq('♦'.red)
    expect(Suit.new('club').to_s).to eq('♣'.light_black)
  end
end
