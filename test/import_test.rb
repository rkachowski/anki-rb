require 'test_helper'

class ImportTest < Minitest::Test
  def test_import
    Anki::apkg_importer.import File.join(File.dirname(__FILE__), 'decks/AnkiDeck.apkg') do |decks|
      assert_equal 2, decks.size

      decks.each do |deck|
        next if deck.name == 'Default'  # The default deck is always there

        assert_equal 'AnkiDeck', deck.name
        assert_equal 3, deck.cards.size

        assert_equal 'Image on front', deck.cards[0].back.content
        assert_equal '', deck.cards[0].front.content
        assert_equal 1, deck.cards[0].front.media.size

        assert_equal 'Image on back', deck.cards[1].front.content
        assert_equal '', deck.cards[1].back.content
        assert_equal 1, deck.cards[1].back.media.size

        assert_equal 'Sound on front', deck.cards[2].back.content
        assert_equal '', deck.cards[2].front.content
        assert_equal 1, deck.cards[2].front.media.size
      end
    end
  end
end
