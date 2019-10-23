require './lib/museum'
require './lib/patron'
require './lib/exhibit'
require 'minitest/autorun'
require 'minitest/pride'


class MuseumTest < Minitest::Test

  def setup
    @dmns = Museum.new("Denver Museum of Nature and Science")
    @gems_and_minerals = Exhibit.new("Gems and Minerals", 0)
    @dead_sea_scrolls = Exhibit.new("Dead Sea Scrolls", 10)
    @imax = Exhibit.new("IMAX", 15)
    @bob = Patron.new("Bob", 20)
    @sally = Patron.new("Sally", 20)
  end

  def test_it_exists
    assert_instance_of Museum, @dmns
  end

  def test_instance_variables
    assert_equal "Denver Museum of Nature and Science", @dmns.name
    assert_equal [], @dmns.exhibits
    assert_equal [], @dmns.patrons
  end

  def test_availablie_exhibits
    @dmns.add_exhibit(@gems_and_minerals)
    assert_equal 1, @dmns.exhibits.length
    assert_equal true, @dmns.exhibits.include?("Gems and Minerals")
    assert_equal false, @dmns.exhibits.include?("IMAX")
    assert_equal false, @dmns.exhibits.include?("Dead Sea Scrolls")


    @dmns.add_exhibit(@dead_sea_scrolls)
    assert_equal 2, @dmns.exhibits.length
    assert_equal false, @dmns.exhibits.include?("IMAX")
    assert_equal true, @dmns.exhibits.include?("Dead Sea Scrolls")
    assert_equal true, @dmns.exhibits.include?("Gems and Minerals")

    @dmns.add_exhibit(@imax)
    assert_equal 3, @dmns.exhibits.length
    assert_equal true, @dmns.exhibits.include?("IMAX")
    assert_equal true, @dmns.exhibits.include?("Dead Sea Scrolls")
    assert_equal true, @dmns.exhibits.include?("Gems and Minerals")
  end

  def test_recommend_exhibits
    @bob.add_interest("Dead Sea Scrolls")
    @bob.add_interest("Gems and Minerals")
    @sally.add_interest("IMAX")
    @dmns.add_exhibit(@dead_sea_scrolls)
    @dmns.add_exhibit(@imax)

    assert_equal 1, @dmns.recommend_exhibits(@bob).length
    assert_equal false, @dmns.recommend_exhibits(@bob).include?("Gems and Minerals")
    assert_equal true, @dmns.recommend_exhibits(@bob).include?("Dead Sea Scrolls")

    assert_equal 1, @dmns.recommend_exhibits(@sally).length
    assert_equal false, @dmns.recommend_exhibits(@sally).include?("Gems and Minerals")
    assert_equal true, @dmns.recommend_exhibits(@sally).include?("IMAX")

    @dmns.add_exhibit(@gems_and_minerals)

    assert_equal 2, @dmns.recommend_exhibits(@bob).length
    assert_equal true, @dmns.recommend_exhibits(@bob).include?("Gems and Minerals")
    assert_equal true, @dmns.recommend_exhibits(@bob).include?("Dead Sea Scrolls")
    assert_equal false, @dmns.recommend_exhibits(@bob).include?("IMAX")

    assert_equal 1, @dmns.recommend_exhibits(@sally).length
    assert_equal false, @dmns.recommend_exhibits(@sally).include?("Gems and Minerals")
    assert_equal true, @dmns.recommend_exhibits(@sally).include?("IMAX")
    assert_equal false, @dmns.recommend_exhibits(@sally).include?("Dead Sea Scrolls")
  end

  def test_admit
    @dmns.admit(@sally)
    assert_equal 1, @dmns.patrons.length
    assert_equal true, @dmns.patrons.include?(@sally)
    assert_equal false, @dmns.patrons.include?(@bob)

    @dmns.admit(@bob)
    assert_equal 2, @dmns.patrons.length
    assert_equal true, @dmns.patrons.include?(@sally)
    assert_equal true, @dmns.patrons.include?(@bob)
  end

  def test_patrons_by_exhibit
    @dmns.add_exhibit(@gems_and_minerals)
    @bob.add_interest(@dead_sea_scrolls)
    @bob.add_interest(@gems_and_minerals)
    @dmns.admit(@bob)
    assert_equal ({@gems_and_minerals => [@bob], @dead_sea_scrolls => []}), @dmns.patrons_by_exhibit_interest
  end


end
