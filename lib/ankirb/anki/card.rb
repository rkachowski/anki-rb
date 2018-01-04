module Anki
  class Card
    attr_accessor :tags, :deck
    attr_reader :id

    def initialize options={}
      @front = CardFace.new(options[:front] || '')
      @back = CardFace.new(options[:back] || '')
      @tags = options[:tags] || []

      @id = Anki::Helper.get_id
    end

    def front
      @front
    end

    def back
      @back
    end

    # returns a new card with the front and back of the original inverted
    def invert
      c = Anki::Card.new(front: @back.to_s, back: @front.to_s)
      c.front = @back.dup
      c.back = @front.dup
      c
    end

    # flips the front and back of this card
    def invert!
      @front, @back = @back, @front
    end

    # is media attached to this card?
    def has_media?
      !@front.media.empty? or !back.media.empty?
    end

    def front= value
      if value.is_a? String
        @front.content = value
      else
        @front = value
      end
    end

    def back= value
      if value.is_a? String
        @back.content = value
      else
        @back = value
      end
    end

    def initialize_copy orig
      super
      @front = Marshal.load(Marshal.dump(orig.front))
      @back = Marshal.load(Marshal.dump(orig.back))
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
    end

    def << thing
      return unless thing and not thing.empty?

      if File.exists?(thing)
        @media << thing
      else
        @content << thing
      end
    end

    def to_s
      @content
    end
  end
end
