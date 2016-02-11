module Anki
  class Deck
    attr_accessor :name, :desc
    attr_reader :id, :cards

    def initialize name
      @name = name
      @id = Time.now.to_i
      @cards = {}
      
    end

    def add_card card
      card.deck = self
      @cards[card.id] = card
    end

    def cards
      @cards.values
    end

    def [] id
      @cards[id]
    end
  end

  class Card
    attr_accessor :front, :back, :tags, :deck
    attr_reader :id


    def initialize options={}
      @front = options[:front] || ''
      @back = options[:back] || ''
      @tags = options[:tags] || []

      @id = Time.now.to_i
    end

    alias :question :front
    alias :question= :front=
    alias :answer :back
    alias :answer= :back=
  end

  class Type
    def self.new_type
      0
    end
  end

  class Queue
    def self.new_queue
      0
    end
  end
end
