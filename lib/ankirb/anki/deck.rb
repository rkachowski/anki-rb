module Anki
  class Deck
    attr_accessor :name, :id
  end

  class Card
    attr_accessor :front, :back, :tags, :deck
  end
end
