# ankirb

[![Gem Version](https://badge.fury.io/rb/ankirb.svg)](https://badge.fury.io/rb/ankirb)  ![Build Status](https://api.travis-ci.org/rkachowski/anki-rb.svg)
 
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

```ruby
require 'ankirb'

card = Anki::Card.new(:front=>"What is the french for cheese omelette?", :back=>"Omelette au fromage")
deck = Anki::Deck.new 'FancyExampleDeck'
deck.add_card card

Anki::apkg.export deck, "~/Anki/Decks" #export to ~/Anki/Decks/FancyExampleDeck.apkg
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/ankirb.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

