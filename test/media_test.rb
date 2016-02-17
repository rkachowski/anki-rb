require 'test_helper'

class MediaTest < Minitest::Test
  def test_export_audio
    deck = Anki::Deck.new 'AudioTestDeck'
    card = Anki::Card.new :front => "front", :back => "back"

    card.back << File.join(File.dirname(__FILE__),'media/tiger.wav')
    deck.add_card card

    Dir.mktmpdir do |tmp|
      file_path = File.join(tmp, 'AudioTestDeck.apkg')

      Anki::apkg.export deck, tmp
      assert File.exists?(file_path), "package file should exist at #{file_path}"

      Dir.mktmpdir do |unzip_tmp|
        current_dir = Dir.pwd
        
        Dir.chdir unzip_tmp

        FileUtils.mv file_path, unzip_tmp
        Zip::File.open('AudioTestDeck.apkg') do |zip_file|
          zip_file.each {|file| file.extract(file.name)}
        end

        assert File.exists?('0'), "audio should have been renamed to '0' "
        assert MimeMagic.by_magic(File.open('0')).audio?, 'file should be audio'

        hash = JSON.parse(File.open('media').read)
        assert hash['0'] == 'tiger.wav', 'media manifest should contain reference to original filename'

        Dir.chdir current_dir
      end
    end
  end
end