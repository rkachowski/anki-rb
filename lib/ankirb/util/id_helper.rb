module Anki
  class Helper
    @@count = 1000
    def self.get_id
      @@count += 1
      @@count
    end
  end
end
