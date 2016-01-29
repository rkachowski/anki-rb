module Anki
  class Deck
    attr_accessor :name, :id

    def initialize name
      @name = name
      @id = Time.now.to_i
    end
  end

  class Card
    attr_accessor :front, :back, :tags, :deck
  end
end
