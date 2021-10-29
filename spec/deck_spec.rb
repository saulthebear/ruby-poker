require 'rspec'
require 'deck'

describe Deck do
  subject { Deck.new }

  describe '#initialize' do
    it 'has 52 cards' do
      expect(subject.cards.length).to eq(52)
    end

    it 'has no duplicates' do
      expect(subject.cards.uniq.length).to eq(52)
    end

    it 'suffles the cards' do
      expect(subject.cards).to_not eq(subject.cards.sort)
    end
  end

  describe '#deal_card' do
    it 'returns the card at the top of the deck' do
      top_card = subject.cards[-1]
      dealt_card = subject.deal_card
      expect(dealt_card).to eq(top_card)
    end

    it 'removes the delt card from the deck' do
      dealt_card = subject.deal_card
      expect(subject.cards).to_not include(dealt_card)
    end
  end
end
