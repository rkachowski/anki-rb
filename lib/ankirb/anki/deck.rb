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
