require_relative 'dfs.rb'
require 'test/unit'

class Test_searching < Test::Unit::TestCase

  def test_first_example #bfs, expected steps:8
    # 2 2 - - - 8
    # 3 - - 5 - 8
    # 3 1 1 5 - 8
    # 3 - - 5 - -
    # 4 - - - 7 7
    # 4 - 6 6 6 -
    car1 = Car.new(color:1, length:2, x:1,y:2, direction:'x')
    car2 = Car.new(color:2, length:2, x:0,y:0, direction:'x')
    car3 = Car.new(color:3, length:3, x:0,y:1, direction:'y')
    car4 = Car.new(color:4, length:2, x:0,y:4, direction:'y')
    car5 = Car.new(color:5, length:3, x:3,y:1, direction:'y')
    car6 = Car.new(color:6, length:3, x:2,y:5, direction:'x')
    car7 = Car.new(color:7, length:2, x:4,y:4, direction:'x')
    car8 = Car.new(color:8, length:3, x:5,y:0, direction:'y')

    node = Node.new(parent:nil,cars:[car1,car2,car3,car4,car5,car6,car7,car8])

    assert_equal(8,Search.new.searching(node,0))
  end

  def test_unsolvable_example #dfs, bfs expected:nil
    # 2 2 - - - 8
    # 3 - - - - 8
    # 3 1 1 - - 8
    # 3 - - - - 5
    # 4 7 7 - - 5
    # 4 - 6 6 6 5
    car1 = Car.new(color:1, length:2, x:1,y:2, direction:'x')
    car2 = Car.new(color:2, length:2, x:0,y:0, direction:'x')
    car3 = Car.new(color:3, length:3, x:0,y:1, direction:'y')
    car4 = Car.new(color:4, length:2, x:0,y:4, direction:'y')
    car5 = Car.new(color:5, length:3, x:5,y:3, direction:'y')
    car6 = Car.new(color:6, length:3, x:2,y:5, direction:'x')
    car7 = Car.new(color:7, length:2, x:1,y:4, direction:'x')
    car8 = Car.new(color:8, length:3, x:5,y:0, direction:'y')

    node = Node.new(parent:nil,cars:[car1,car2,car3,car4,car5,car6,car7,car8])

    assert_equal(nil,Search.new.searching(node,0))
    assert_equal(nil,Search.new.searching(node,1))
  end

  def test_harder_example #bfs, expected steps: 49
    # 13 13 13 4  5  6
    # 2  12 12 4  5  6
    # 2  -  1  1  5  6
    # 11 11 3  -  -  -
    # -  7  3  -  9  9
    # -  7  8  8  10 10
    cars = [
    car1 = Car.new(color:1, length:2, x:2,y:2, direction:'x'),
    car2 = Car.new(color:2, length:2, x:0,y:1, direction:'y'),
    car3 = Car.new(color:3, length:2, x:2,y:3, direction:'y'),
    car4 = Car.new(color:4, length:2, x:3,y:0, direction:'y'),
    car5 = Car.new(color:5, length:3, x:4,y:0, direction:'y'),
    car6 = Car.new(color:6, length:3, x:5,y:0, direction:'y'),
    car7 = Car.new(color:7, length:2, x:1,y:4, direction:'y'),
    car8 = Car.new(color:8, length:2, x:2,y:5, direction:'x'),
    car9 = Car.new(color:9, length:2, x:4,y:4, direction:'x'),
    car10 = Car.new(color:10, length:2, x:4,y:5, direction:'x'),
    car11 = Car.new(color:11, length:2, x:0,y:3, direction:'x'),
    car12 = Car.new(color:12, length:2, x:1,y:1, direction:'x'),
    car13 = Car.new(color:13, length:3, x:0,y:0, direction:'x')]

    node = Node.new(parent:nil,cars:cars)

    assert_equal(49,Search.new.searching(node,0))
  end
end