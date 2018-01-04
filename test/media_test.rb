require 'test_helper'

class MediaTest < Minitest::Test
  def test_export_audio
    deck = Anki::Deck.new 'AudioTestDeck'
    card = Anki::Card.new :front => "front", :back => "back"

    card.back << File.join(File.dirname(__FILE__), 'media/tiger.wav')
    deck.add_card card

    orig_back = card.back.to_s

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

      assert_equal orig_back, card.back.to_s, "Card body is not changed upon export"
    end
  end


  def test_export_image
    deck = Anki::Deck.new 'ImageTestDeck'
    card = Anki::Card.new :front => 'front', :back => 'back {{img}}'

    card.back << File.join(File.dirname(__FILE__), 'media/awesome.jpg')
    deck.add_card card

    Dir.mktmpdir do |tmp|
      file_path = File.join(tmp, 'ImageTestDeck.apkg')

      Anki::apkg.export deck, tmp
      assert File.exists?(file_path), "package file should exist at #{file_path}"

      Zip::File.open(file_path) do |zip_file|
        zip_file.each { |file| file.extract(File.join(tmp,file.name)) }
      end

      assert File.exists?(File.join(tmp,'0')), "image should have been renamed to '0' "
      assert MimeMagic.by_magic(File.open(File.join(tmp,'0'))).image?, 'file should be image'

      hash = JSON.parse(File.open(File.join(tmp,'media')).read)
      assert hash['0'] == 'awesome.jpg', 'media manifest should contain reference to original filename'
    end
  end

  def test_export_video
    deck = Anki::Deck.new 'VideoTestDeck'
    card = Anki::Card.new :front => 'front', :back => 'back'

    card.back << File.join(File.dirname(__FILE__), 'media/horia.mp4')
    deck.add_card card

    Dir.mktmpdir do |tmp|
      file_path = File.join(tmp, 'VideoTestDeck.apkg')

      Anki::apkg.export deck, tmp
      assert File.exists?(file_path), "package file should exist at #{file_path}"

      Zip::File.open(file_path) do |zip_file|
        zip_file.each { |file| file.extract(File.join(tmp,file.name)) }
      end

      assert File.exists?(File.join(tmp,'0')), "video should have been renamed to '0' "
      assert MimeMagic.by_magic(File.open(File.join(tmp,'0'))).video?, 'file should be video'

      hash = JSON.parse(File.open(File.join(tmp,'media')).read)
      assert hash['0'] == 'horia.mp4', 'media manifest should contain reference to original filename'
    end
  end
end

