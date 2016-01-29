require 'test_helper'

class ExportTest < Minitest::Test
  def test_export
    deck = Anki::Deck.new 'ExportTestDeck'
    deck.add_card Anki::Card.new

    Dir.mktmpdir do |tmp|
      Anki::apkg.export deck, 'TestPackage'

      file_path = File.join(tmp, 'TestPackage')
      assert File.exists? file_path, "package file should exist at #{file_path}"
    end

  end
end
