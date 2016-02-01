require 'zip'

module Anki
  class APKGExporter

    def self.export deck, path
      Dir.mktmpdir do |dir|
        export_deck deck

        archive = Zip::File.open(path + '.apkg', Zip::File::CREATE)

        Dir.glob(File.join(dir,'*')).each do |file|
          archive.add(file,file)
        end

        archive.close()
      end
    end
    private

    def self.export_deck deck
      #create db
      #export deck properties
      #export all cards in deck

      #TODO: export media
    end
  end
end

