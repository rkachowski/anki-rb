require 'mimemagic'
module Anki
  class Media

    def self.process filepath, str
      media = MimeMagic.by_magic(File.open(filepath))
      case
        when media.image?
          tag = %(<img src="#{File.basename(filepath)}"/>)

          if str.match(/{{img}}/)
            str.sub!(/{{img}}/, tag)
          else
            str << tag unless str.include? tag
          end
        when media.audio?, media.video? #video also has a sound tag, idk
          tag = "[sound:#{File.basename(filepath)}]"
          str << tag unless str.include? tag
        else
          raise "Unknown media type - #{filepath}"
      end
    end

    def self.valid_media? filepath
      return false unless File.exists?(filepath)

      media = MimeMagic.by_magic(File.open(filepath))
      if media.image? or media.video? or media.audio?
        true
      else
        false
      end
    end

  end
end
