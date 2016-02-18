require 'test_helper'

class MediaTest < Minitest::Test
  def test_export_audio
    deck = Anki::Deck.new 'AudioTestDeck'
    card = Anki::Card.new :front => "front", :back => "back"

    card.back << File.join(File.dirname(__FILE__), 'media/tiger.wav')
    deck.add_card card

    Dir.mktmpdir do |tmp|
      file_path = File.join(tmp, 'AudioTestDeck.apkg')

      Anki::apkg.export deck, tmp
      assert File.exists?(file_path), "package file should exist at #{file_path}"

      Zip::File.open(file_path) do |zip_file|
        zip_file.each { |file| file.extract(File.join(tmp,file.name)) }
      end

      assert File.exists?(File.join(tmp,'0')), "audio should have been renamed to '0' "
      assert MimeMagic.by_magic(File.open(File.join(tmp,'0'))).audio?, 'file should be audio'

      hash = JSON.parse(File.open(File.join(tmp,'media')).read)
      assert hash['0'] == 'tiger.wav', 'media manifest should contain reference to original filename'
    end
  end
end
