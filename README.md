# ankirb

[![Gem Version](https://badge.fury.io/rb/ankirb.svg)](https://badge.fury.io/rb/ankirb)
 
A basic gem to create [Anki](http://ankisrs.net/) decks (.apkg)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ankirb'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ankirb

## Usage

```
require 'ankirb'

deck = Anki::Deck.new 'FancyExampleDeck'
deck.add_card Anki::Card.new(:front=>"What is the french for cheese omelette?", :back=>"Omelette au fromage")

Anki::apkg.export deck, "~/Anki/Decks" #export to ~/Anki/Decks/FancyExampleDeck.apkg
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/ankirb.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

