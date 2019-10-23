require './lib/patron'
require 'minitest/autorun'
require 'minitest/pride'

class PatronTest < Minitest::Test

  def setup
    @bob = Patron.new("Bob", 20)
  end

  def test_it_exists
    assert_instance_of Patron, @bob
  end

  def test_instance_variables
    assert_equal "Bob", @bob.name
    assert_equal 20, @bob.spending_money
    assert_equal [], @bob.interests
  end

  def test_add_interest
    @bob.add_interest("Dead Sea Scrolls")
    assert_equal 1, @bob.interests.length
    assert_equal true, @bob.interests.include?("Dead Sea Scrolls")
    @bob.add_interest("Gems and Minerals")
    assert_equal 2, @bob.interests.length
    assert_equal true, @bob.interests.include?("Gems and Minerals")
  end

end
