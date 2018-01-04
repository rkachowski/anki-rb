# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ankirb/version'

Gem::Specification.new do |spec|
  spec.name          = "ankirb"
  spec.version       = Anki::VERSION
  spec.authors       = ["Donald Hutchison"]
  spec.email         = ["git@toastymofo.net"]

  spec.summary       = %q{A gem to create Anki decks for loading in an Anki flashcard application}
  spec.description   = %q{A library that lets you export apkg packaged decks for Anki. Designed to deal with creation / exporting and not much else}
  spec.homepage      = "https://github.com/rkachowski/anki-rb"
  spec.license       = "MIT"


  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'pry-byebug'
  spec.add_runtime_dependency 'rake', '~> 10.5'
  spec.add_runtime_dependency 'base91', '0.0.1'
  spec.add_runtime_dependency 'rubyzip', '~> 1.1'
  spec.add_runtime_dependency 'sqlite3', '~> 1.3'
  spec.add_runtime_dependency 'mimemagic', '~> 0.3'

end
