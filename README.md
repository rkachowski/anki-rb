# ankirb

[![Gem Version](https://badge.fury.io/rb/ankirb.svg)](https://badge.fury.io/rb/ankirb)  [![Build Status](https://travis-ci.org/rkachowski/anki-rb.svg?branch=master)](https://travis-ci.org/rkachowski/anki-rb)
 
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

#create a deck
deck = Anki::Deck.new 'FancyExampleDeck'

#create a basic card
card = Anki::Card.new(:front=>"What is the french for cheese omelette?", :back=>"Omelette au fromage")

#add audio to the back
card.back << "dexters_lab_omelette.wav"

#add card to the deck
deck.add_card card

#export to ~/Anki/Decks/FancyExampleDeck.apkg
Anki::apkg.export deck, "~/Anki/Decks" 
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/rkachowski/ankirb.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

