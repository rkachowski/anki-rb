require 'test_helper'

class DeckTest < Minitest::Test
  def test_construct_deck
    deck = Anki::Deck.new "TestDeck"

    assert(deck, "deck should exist")
    assert_equal("TestDeck", deck.name, "name should match")
    assert_kind_of(Fixnum, deck.id, "id should be a fixnum (int)")
  end
end
