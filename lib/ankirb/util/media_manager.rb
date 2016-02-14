require 'mimemagic'
module Anki
  class MediaManager
    attr_reader :relocations
    @@relocations = []

    def self.get_tag_for filepath
      media = MimeMagic.by_magic(File.open(filepath))
      case
        when media.image?
        when media.video?
        when media.audio?
          self.add_relocation filepath
          "[sound:#{File.basename(filepath)}]"
        else
          raise "Unknown media type - #{filepath}"
      end
    end

    private

    def self.add_relocation filepath
      relocation = {:source => filepath, :destination => @@relocations.length, :name =>File.basename(filepath)}
      @@relocations << relocation
    end
  end
end
