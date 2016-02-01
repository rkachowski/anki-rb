
module Anki
  Gem.find_files("ankirb/**/*.rb").each { |path| require path }

  def self.apkg
    APKGExporter
  end
end
