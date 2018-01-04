# ankirb

[![Gem Version](https://badge.fury.io/rb/ankirb.svg)](https://badge.fury.io/rb/ankirb)  [![Build Status](https://travis-ci.org/rkachowski/anki-rb.svg?branch=master)](https://travis-ci.org/rkachowski/anki-rb)
 
A basic gem to create [Anki](http://ankisrs.net/) decks (.apkg). Supports integrated media (audio, images and videos).

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

#add the reverse version of the card
deck.add_card card.invert 

#export to ~/Anki/Decks/FancyExampleDeck.apkg
Anki::apkg.export deck, "~/Anki/Decks" 
```

### Media types

Media can be added to a card face via the `<<` operator, just pass a string that points to a valid media file and the lib will convert + package the file. 

For images, the position of the image in the card can be set by using a placeholder `{{img}}`. 

```ruby
card = Anki::Card.new :front => "{{img}} text after image", :back => "text before image {{img}}"
card.front << "front_img.jpg"
card.back << "back_img.jpg"
```

If no placeholder is present the image will just be added at the end. If multiple placeholders are present, they'll be replaced sequentially with the image files added to the card.

As with anki, html tags can be used for more styling in the card content. Card model / css template support may be added in future.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/rkachowski/ankirb.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

