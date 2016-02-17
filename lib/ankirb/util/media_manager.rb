require 'mimemagic'
module Anki
  class MediaManager


    def self.get_tag_for filepath
      media = MimeMagic.by_magic(File.open(filepath))
      case
        when media.image?
        when media.video?
        when media.audio?
          "[sound:#{File.basename(filepath)}]"
        else
          raise "Unknown media type - #{filepath}"
      end
    end

    def self.valid_media? filepath
      media = MimeMagic.by_magic(File.open(filepath))
      if media.image? or media.video? or media.audio?
        true
      else
        false
      end
    end

  end
end
