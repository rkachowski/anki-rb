require 'logger'

module Anki
  Gem.find_files("ankirb/**/*.rb").each { |path| require path }

  @@logger = Logger.new(STDOUT)
  @@logger.level = ENV["DEBUG"] ? Logger::DEBUG : Logger::WARN

  def self.apkg
    APKGExporter
  end

  def self.logger
    @@logger
  end
end
