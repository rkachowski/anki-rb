module Anki
  class Card
    attr_accessor :tags, :deck
    attr_reader :id


    def initialize options={}
      @front = CardFace.new(options[:front] || '')
      @back = CardFace.new(options[:back] || '')
      @tags = options[:tags] || []

      @id = Time.now.to_i
    end

    def front
      @front
    end

    def back
      @back
    end

    def has_media?
      !@front.media.empty? or !back.media.empty?
    end
    def front= value
      @front.content = value
    end

    def back= value
      @back.content = value
    end

    alias :question :front
    alias :question= :front=
    alias :answer :back
    alias :answer= :back=
  end

  class CardFace
    attr_accessor :content, :media

    def initialize content
      @content = content
      @media = []
      scan_content_for_media
    end

    def << thing
      if File.exists?(thing)
        @media << thing
      else
        @content << thing
        scan_content_for_media
      end
    end

    def to_s
      @content
    end
    private

    def scan_content_for_media
      #todo: check if content contains a media reference and apply that
    end
  end
end
