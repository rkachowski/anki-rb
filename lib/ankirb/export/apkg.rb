require 'zip'
require 'json'
require 'fileutils'
require 'base91'
module Anki

  SCHEMA_VERSION = 11 unless const_defined?(:SCHEMA_VERSION)

  class APKGExporter

    def self.export deck, path
      Dir.mktmpdir do |dir|
        Dir.chdir(dir) do
          db = DB.create 'collection.anki2'

          export_deck deck, db
          export_media deck
          filename = deck.name + '.apkg'
          archive = Zip::File.open(filename, Zip::File::CREATE)

          Dir.glob('*').each do |file|
            archive.add(file, file)
          end

          archive.close()

          FileUtils.move(filename, path)
        end
      end
    end

    private
    def self.export_media deck
      #TODO: correctly export media
      File.open('media', 'w'){|f| f << Defaults.media }
    end

    def self.export_deck deck, db

      decks = {}
      decks['1'] = Defaults.deck
      decks[deck.id.to_s] = deck_to_json deck

      model = Defaults.model(deck.id)

      db.execute "insert into col values(
        #{deck.id},
        #{Time.now.to_i},
        #{Time.now.to_i},
        #{Time.now.to_i},
        #{SCHEMA_VERSION},
        0,
        -1,
        0,
        '#{Defaults.conf}',
        '#{model.to_json}',
        '#{JSON.generate(decks)}',
        '#{Defaults.dconf}',
        '#{Defaults.tags}'
      )"

      deck.cards.each do |card|
        #flds is front and back of card separated by \xf1
        flds_bytes = [card.front.content, card.back.content].map{|f|f.bytes}.insert(1, 'f1'.hex)
        flds = flds_bytes.flatten.pack('C*').force_encoding('utf-8')

        note = {
            :id => Time.now.to_i,
            :guid => Base91.encode(Random.new.rand(2**63).to_s),
            :mid => Defaults.model_id,
            :mod => Time.now.to_i,
            :usn => -1,
            :tags => nil,
            :flds => flds,
            :sfld => card.front.content.gsub(/<\/?[^>]*>/, ''), #v dirty html sanitization
            :csum => 0,
            :flags => 0,
            :data => nil
        }

        add_note_to_db note, db
        add_card_to_db note, deck, db
      end

    end

    def self.add_card_to_db(note, deck, db)
      db.execute "insert into cards values(
        #{Time.now.to_i},
        #{note[:id]},
        #{deck.id},
        0,
        #{Time.now.to_i},
        -1,
        #{Type.new_type},
        #{Queue.new_queue},
        #{Random.new.rand(2**10)},
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        '')"
    end

    def self.add_note_to_db note, db
      db.execute "insert into notes values(
        #{note[:id]},
        '#{note[:guid]}',
        #{note[:mid]},
        #{note[:mod]},
        #{note[:usn]},
        '#{note[:tags]}',
        '#{note[:flds]}',
        '#{note[:sfld]}',
        #{note[:csum]},
        #{note[:flags]},
        '#{note[:data]}')"
    end

    def self.deck_to_json deck
      JSON.parse %Q({"name": "#{deck.name}", "extendRev": 50, "usn": -1, "collapsed": false, "browserCollapsed": true, "newToday": [29, 0], "timeToday": [29, 0], "dyn": 0, "extendNew": 10, "conf": 1, "revToday": [29, 0], "lrnToday": [29, 0], "id": #{deck.id}, "mod": 1454538410, "desc": "#{deck.desc}"})
    end
  end
end

