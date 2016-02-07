require 'zip'
require 'json'
require 'fileutils'

module Anki

  SCHEMA_VERSION = 11

  class APKGExporter

    def self.export deck, path
      Dir.mktmpdir do |dir|
        Dir.chdir(dir) do
          db = DB.create 'collection.anki2'

          export_deck deck, db
          filename = deck.name + '.apkg'
          archive = Zip::File.open(filename, Zip::File::CREATE)

          Dir.glob('*').each do |file|
            archive.add(file,file)
          end

          archive.close()

          FileUtils.move(filename,path)
          #copy archive to path
        end
      end
    end
    private

    def self.export_deck deck, db

      decks = {}
      decks["1"] = Defaults.deck.clone
      decks[deck.id.to_s] = deck_to_json deck

      model = Defaults.model(deck.id)
      #export deck properties
      #export all cards in deck

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
        '#{model}',
        '#{JSON.generate(decks)}',
        '#{Defaults.dconf}',
        '#{Defaults.tags}'
      )"

      #TODO: export media
    end

    def self.deck_to_json deck
      %Q({"name": "#{deck.name}", "extendRev": 50, "usn": -1, "collapsed": false, "browserCollapsed": true, "newToday": [29, 0], "timeToday": [29, 0], "dyn": 0, "extendNew": 10, "conf": 1, "revToday": [29, 0], "lrnToday": [29, 0], "id": #{deck.id}, "mod": 1454538410, "desc": "#{deck.desc}"})
    end
  end
end

