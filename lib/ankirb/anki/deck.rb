module Anki
  class Deck
    attr_accessor :name, :desc
    attr_reader :id, :cards

    def initialize name
      @name = name
      @id = Anki::Helper.get_id
      @cards = {}

      #change @cards#to_s to prevent recursive output via parent / child relationship
      class << @cards
        def to_s
          "#< #{self.keys.count} cards>"
        end
        alias_method :inspect, :to_s
      end
    end

    def add_card card
      card.deck = self
      @cards[card.id] = card
    end

    def add_card_with_inversion card
      add_card card
      add_card card.invert
    end

    def add_inversions
      @cards.values.each {|c| add_card c.invert }
    end

    def invert!
      @cards.values.each {|c| c.invert! }
    end

    def cards
      @cards.values
    end

    def [] id
      @cards[id]
    end

    def initialize_copy(orig)
      super
      orig.instance_variable_set(:@cards, {})
      @cards.values.each { |c| orig.add_card c.dup }
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
