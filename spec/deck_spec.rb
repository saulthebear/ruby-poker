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

  describe '#deal_cards' do
    it 'calls #deal_card' do
      expect(subject).to receive(:deal_card).exactly(5).times
      subject.deal_cards(5)
    end

    it 'returns an array with the number of cards requested' do
      cards = subject.deal_cards(5)
      expect(cards).to be_an(Array)
      expect(cards.length).to eq(5)
      expect(cards).to all(be_a(Card))
    end

    it 'raises an error for an incorrect number' do
      expect { subject.deal_cards(0) }.to raise_error ArgumentError
      expect { subject.deal_cards(53) }.to raise_error ArgumentError
    end
  end
  
  describe '#return_cards' do
    it 'adds the cards to the deck' do
      card1 = subject.deal_card
      card2 = subject.deal_card
      expect(subject.cards).to_not include(card1, card2)
      subject.return_cards([card1, card2])
      expect(subject.cards).to include(card1, card2)
    end
    
    it 'raises an error if the card is already in the deck' do
      card1 = Card.new(:heart, :A)
      expect { subject.return_cards([card1]) }.to raise_error ArgumentError
    end
    
    it 'raises an error if the cards aren\'t of type Card' do
      expect { subject.return_cards(['Ace of Hearts']) }.to raise_error ArgumentError
    end
  end

  describe '#shuffle!' do
    it 'changes the card order' do
      before_suffle = subject.cards
      subject.shuffle!
      expect(before_suffle).to_not eq(subject.cards)
      expect(before_suffle).to match_array(subject.cards)
    end
  end
end
