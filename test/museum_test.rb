require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require './lib/exhibit'
require './lib/patron'
require './lib/museum'

class MuseumTest < Minitest::Test
  def test_it_exists
    dmns = Museum.new("Denver Museum of Nature and Science")

    assert_instance_of Museum, dmns
  end

  def test_it_has_attributes
    dmns = Museum.new("Denver Museum of Nature and Science")

    assert_equal "Denver Museum of Nature and Science", dmns.name
    assert_equal [], dmns.exhibits
  end

  def test_it_can_add_exhibits
    dmns = Museum.new("Denver Museum of Nature and Science")
    gems_and_minerals = Exhibit.new("Gems and Minerals", 0)
    dead_sea_scrolls = Exhibit.new("Dead Sea Scrolls", 10)
    imax = Exhibit.new("IMAX", 15)

    dmns.add_exhibit(gems_and_minerals)
    dmns.add_exhibit(dead_sea_scrolls)
    dmns.add_exhibit(imax)

    expected = [gems_and_minerals, dead_sea_scrolls, imax]

    assert_equal expected, dmns.exhibits
  end

  def test_it_can_recommend_exhibits_to_interested_patrons
    dmns = Museum.new("Denver Museum of Nature and Science")
    gems_and_minerals = Exhibit.new("Gems and Minerals", 0)
    dead_sea_scrolls = Exhibit.new("Dead Sea Scrolls", 10)
    imax = Exhibit.new("IMAX", 15)
    dmns.add_exhibit(gems_and_minerals)
    dmns.add_exhibit(dead_sea_scrolls)
    dmns.add_exhibit(imax)

    bob = Patron.new("Bob", 20)
      bob.add_interest("Dead Sea Scrolls")
      bob.add_interest("Gems and Minerals")
    sally = Patron.new("Sally", 20)
      sally.add_interest("IMAX")

    dmns.recommend_exhibits(bob)
    dmns.recommend_exhibits(sally)

    expected_bob = [dead_sea_scrolls, gems_and_minerals]
    expected_sally = [imax]
    assert_equal expected_bob, dmns.recommend_exhibits(bob)
    assert_equal expected_sally, dmns.recommend_exhibits(sally)
  end

  def test_it_can_show_patrons_by_museum_interest
    dmns = Museum.new("Denver Museum of Nature and Science")
    gems_and_minerals = Exhibit.new("Gems and Minerals", 0)
    dead_sea_scrolls = Exhibit.new("Dead Sea Scrolls", 10)
    imax = Exhibit.new("IMAX", 15)
    dmns.add_exhibit(gems_and_minerals)
    dmns.add_exhibit(dead_sea_scrolls)
    dmns.add_exhibit(imax)
    bob = Patron.new("Bob", 20)
      bob.add_interest("Dead Sea Scrolls")
      bob.add_interest("Gems and Minerals")
    sally = Patron.new("Sally", 20)
      sally.add_interest("Dead Sea Scrolls")
    dmns.recommend_exhibits(bob)
    dmns.recommend_exhibits(sally)

    expected = {
      #<Exhibit:0x00007fb202238618...> => [#<Patron:0x00007fb2011455b8...>],
      #<Exhibit:0x00007fb202248748...> => [#<Patron:0x00007fb2011455b8...>, #<Patron:0x00007fb20227f8b0...>],
      #<Exhibit:0x00007fb20225f8d0...> => []
    }

    assert_equal expected, dmns.patrons_by_exhibit_interest
  end


end
