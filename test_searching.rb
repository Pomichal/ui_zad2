require_relative 'dfs.rb'
require 'test/unit'

class Test_searching < Test::Unit::TestCase

  def test_first_example
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

  def test_unsolvable_example

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
  end
end