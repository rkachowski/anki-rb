
module Anki
  Gem.find_files("ankirb/**/*.rb").each { |path| require path }

  def self.apkg
    APKGExporter
  end

  def self.apkg_importer
    # TODO: This is daft
    APKGImporter
  end
end
