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
  spec.description   = %q{TODO: Write a longer description or delete this line.}
  spec.homepage      = "TODO: Put your gem's website or public repo URL here."
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_runtime_dependency 'rake', '~> 10.5.0'
  spec.add_runtime_dependency 'base91', '0.0.1'
  spec.add_runtime_dependency 'rubyzip', '~> 1.1.7'
  spec.add_runtime_dependency 'sqlite3', '~> 1.3.11'
end
