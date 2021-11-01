require 'rspec'
require 'game'
require 'deck'
require 'player'

describe Game do
  describe '#initialize' do
    let(:number_of_players) { 4 }
    subject { Game.new(number_of_players) }

    it 'has a deck' do
      expect(subject.deck).to be_a(Deck)
    end

    it 'has players' do
      expect(subject.players).to all(be_a(Player))
      expect(subject.players.length).to be(number_of_players)
    end

    it 'has a pot' do
      expect(subject.pot).to be_an(Integer)
    end

    it 'raises an error unless an integer is passed in' do
      expect { Game.new('four') }.to raise_error ArgumentError
    end

    it 'raises an error unless a positive integer is passed in' do
      err_msg_snippet = /number_of_players/
      expect { Game.new(0) }.to raise_error ArgumentError, err_msg_snippet
      expect { Game.new(-5) }.to raise_error ArgumentError, err_msg_snippet
      expect { Game.new(4) }.to_not raise_error
    end
  end
end
