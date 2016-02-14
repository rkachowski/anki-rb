require 'test_helper'

class MediaTest < Minitest::Test
  def test_export_audio
    deck = Anki::Deck.new 'AudioTestDeck'
    card = Anki::Card.new :front => "front", :back => "back"

    card.back << File.join(File.dirname(__FILE__),'media/tiger.wav')
    deck.add_card card

    assert !card.back.content.include?('media/tiger.wav'), 'Directory name should be stripped from media embed'

    Dir.mktmpdir do |tmp|
      file_path = File.join(tmp, 'AudioTestDeck.apkg')

      Anki::apkg.export deck, tmp
      assert File.exists?(file_path), "package file should exist at #{file_path}"
    end
  end
end