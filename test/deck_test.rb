require 'test_helper'

class DeckTest < Minitest::Test
  def test_construct_deck
    deck = Anki::Deck.new 'TestDeck'

    assert(deck, 'deck should exist')
    assert_equal('TestDeck', deck.name, 'name should match')
    assert_kind_of(Fixnum, deck.id, 'id should be a fixnum (int)')
  end

  def test_add_card
    deck = Anki::Deck.new 'TestDeck'

    card = Anki::Card.new
    deck.add_card card

    assert(deck.cards.include?(card), 'deck should have the card')
    assert_equal(deck, card.deck, 'deck reference should be set')
    assert_equal(deck[card.id], card, 'should retrieve card by id')
  end
end
