require './lib/exhibit'
require 'minitest/autorun'
require 'minitest/pride'

class ExhibitTest < Minitest::Test

  def setup
    @exhibit = Exhibit.new("Gems and Minerals", 0)
  end

  def test_it_exists
    assert_instance_of Exhibit, @exhibit
  end

  def test_instance_variables
    assert_equal "Gems and Minerals", @exhibit.name
    assert_equal 0, @exhibit.cost
  end


end
