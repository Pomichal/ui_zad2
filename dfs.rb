#
# breadt-first search
# def bfs (source, goal)
#   open_set = []
#   closed_set = Set.new
#
#   while not open_set.is_empty?
#     node = open_set.shift
#
#     return node if node == goal
#
#     node.get_children.each do |child|
#       open_set.push(child)
#     end
#   end

class Car
  attr_accessor :color, :length, :x, :y, :direction

  def initialize(options = {})
    @color = options[:color]
    @length = options[:length]
    @x = options[:x]
    @y = options[:y]
    @direction = options[:direction]
  end

  def setx(x)
    self.x = x
  end

  def sety(y)
    self.y = y
  end

  def is_there?(x,y)     #return true, if car is on place x y
    self.length.times do |len|
      my_x = self.x
      my_x += len if direction == 'x'
      my_y = self.y
      my_y += len if direction == 'y'
      return true if(x == my_x and y == my_y)
    end
    false
  end
end

class Node
  attr_accessor :parent, :children, :cars

  Map_x = 6 - 1  #x size of the map
  Map_y = 6 - 1 #y size of the map

  def initialize(options = {})
    @parent = options[:parent]
    @children = []
    @cars = options[:cars]
  end

  def set_children
    @cars.each do |car|
      x = car.x
      y = car.y
      color = car.color
      if car.direction == 'x'
        while is_free?(car, x + car.length, y)
          new_node(color, x + 1, y)
          x += 1
        end
        x = car.x
        while is_free?(car, x - 1, y)
          new_node(color, x - 1, y)
          x -= 1
        end
        x = car.x
      else
        while is_free?(car, x, y + car.length)
          new_node(color, x, y + 1)
          y += 1
        end
        y = car.y
        while is_free?(car, x, y - 1)
          new_node(color, x, y - 1)
          y -= 1
        end
      end
    end
  end

  def is_free?(car,x,y)
    if x<0 or x>Map_x or y<0 or y>Map_y
      return false
    end
    @cars.each do |c|
      if(c != car and c.is_there?(x, y))
        return false
      end
    end
    true
  end

  def new_node(color, x, y)
    tmp_cars = []
    cars.each {|c| tmp_cars.push(c.dup)}
    n = Node.new(parent: self, cars: tmp_cars)
    new_car = (n.cars.select {|ca| ca.color == color})[0]
    new_car.setx x
    new_car.sety y
    puts new_car.color.to_s + ' ' + new_car.x.to_s + ' ' + new_car.y.to_s
    children.push(n)
  end

end

car1 = Car.new(color:'cervene', length:2, x:1,y:2, direction:'x')
car2 = Car.new(color:'oranzove', length:2, x:0,y:0, direction:'x')
car3 = Car.new(color:'zlte', length:3, x:0,y:1, direction:'y')
car4 = Car.new(color:'fialove', length:2, x:0,y:4, direction:'y')
car5 = Car.new(color:'zelene', length:3, x:3,y:1, direction:'y')
car6 = Car.new(color:'svetlomodre', length:3, x:2,y:5, direction:'x')
car7 = Car.new(color:'sive', length:2, x:4,y:4, direction:'x')
car8 = Car.new(color:'tmavomodre', length:3, x:5,y:0, direction:'y')

node = Node.new(parent:nil,cars:[car1,car2, car3, car4, car5, car6, car7, car8])

node.set_children

puts "###############"

node.children.each do |c|
  c.cars.each {|car| puts car.color.to_s + ' ' + car.x.to_s + ' ' + car.y.to_s}
  puts "###############"
end