require 'test_helper'
class CardTest < Minitest::Test

  def test_invert
    card = Anki::Card.new front: "front", back: "back"

    inv = card.invert

    assert_equal("front", inv.back.to_s, "Should be switched")
    assert_equal("back", inv.front.to_s)

    card.invert!
    assert_equal("front", card.back.to_s)
    assert_equal("back", card.front.to_s)
  end
end