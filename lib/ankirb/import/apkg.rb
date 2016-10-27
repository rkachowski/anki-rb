require 'zip'
require 'json'
require 'fileutils'
require 'base91'

module Anki
  class APKGImporter
    def self.import(filename)
      output_decks = []

      Dir.mktmpdir do |dir|
        # Archive
        Zip::File.open(filename) do |archive|
          archive.each do |file|
            file.extract(File.join(dir, file.name))
          end
        end

        media = self.parse_media_mapping(File.join(dir, 'media'))
        db = SQLite3::Database.new File.join(dir, 'collection.anki2')
        cols = db.execute('select id, decks from col')

        cols.each do |col|
          deck_json = JSON.parse(col[1])

          deck_json.each_pair do |deck_id, deck|
            deck_name = deck['name']
            output_deck = Anki::Deck.new deck_name

            # Cards
            cards = db.execute('select id, nid from cards where did = ?', deck['id'])
            cards.each do |card|
              notes = db.execute('select id, flds from notes where id = ?', card[1])
              notes.each do |note|
                front, back = note[1].split("\x1f")
                front_text, front_media = self.parse_text(front)
                back_text, back_media = self.parse_text(back)

                # TODO: Is it one card per card or per note?
                # And where should the id come from?
                output_card = Anki::Card.new(id: note[0], front: front_text,
                  back: back_text)

                front_media.each do |m|
                  output_card.front << File.join(dir, media[m])
                end

                back_media.each do |m|
                  output_card.back << File.join(dir, media[m])
                end

                output_deck.add_card output_card
              end
            end

            output_decks << output_deck
          end
        end

        # We need to yield the result before the temp directory
        # is removed
        yield output_decks if block_given?
      end

      output_decks
    end

    def self.parse_text(text)
      # Find every occurence of images, sounds and video, remove
      # them from text, add it to media. Return resulting text
      # and list of media
      re = /<img src="(.*?)" *\/>|\[sound:(.*?)\]/
      media = text.scan(re).flatten.reject { |e| e == nil }
      return [text.gsub(re, ''), media]
    end

    def self.parse_media_mapping(filename)
      # Media is a hash from number filename to real filename
      # We need the inverse
      JSON.parse(File.read(filename)).invert
    end
  end
end
