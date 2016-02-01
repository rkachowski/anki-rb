require 'zip'

module Anki
  class APKGExporter

    def self.export deck, path
      Dir.mktmpdir do |dir|
        #create all files in dir here

        archive = Zip::File.open(path + '.apkg', Zip::File::CREATE)

        Dir.glob(File.join(dir,'*')).each do |file|
          archive.add(file,file)
        end

        archive.close()
      end
    end
  end
end

