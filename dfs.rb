Map_x = 6 - 1  #x size of the map
Map_y = 6 - 1 #y size of the map


require 'set'

class Search
  ##breadt-first search
  def bfs (source)
    open_set = []
    closed_set = Set.new

    open_set.push(source)

    while not open_set.empty?
      node = open_set.shift

      if goal?(node)
        print_result node
        return
      end

      node.set_children
      node.children.each do |child|
        if(closed_set.add? child.number)
        open_set.push(child)
        end
      end
    end
    print "riesenie neexistuje"
  end

  def dfs (source)
    open_set = []
    closed_set = Set.new

    open_set.push(source)

    while not open_set.empty?
      node = open_set.shift

      if goal?(node)
        print_result node
        return
      end

      node.set_children
      node.children.each do |child|
        if(closed_set.add? child.number)
          open_set.unshift(child)
        end
      end
    end
    print "riesenie neexistuje"
  end


  def goal?(node)
    new_car = (node.cars.select {|car| car.color == 1})[0]
    return true if(new_car.x == Map_x - new_car.length + 1)
    false
  end

  def print_result(node)
    result = []
    while node.change != ""
      result.unshift node.change
      node = node.parent
    end
    result.each do |z|
      puts z
    end
  end

end

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
  attr_accessor :parent, :children, :cars, :number, :change

  def initialize(options = {})
    @parent = options[:parent]
    @children = []
    @cars = options[:cars]
    @number = 0
    @change = ""
  end

  def set_number
    tmp = 0
    cars.each do |car|
      tmp += (10 ** car.color) * (car.x + car.y)
    end
    @number = tmp
  end

  def set_children
    @cars.each do |car|
      x = car.x
      y = car.y
      color = car.color
      if car.direction == 'x'
        while is_free?(car, x + car.length, y)
          new_node(color, x + 1, y, "Vpravo(#{get_color color}, #{x - car.x + 1})")
          x += 1
        end
        x = car.x
        while is_free?(car, x - 1, y)
          new_node(color, x - 1, y,"Vlavo(#{get_color color}, #{car.x - x + 1})")
          x -= 1
        end
        x = car.x
      else
        while is_free?(car, x, y + car.length)
          new_node(color, x, y + 1,"Dole(#{get_color color}, #{y - car.y + 1})")
          y += 1
        end
        y = car.y
        while is_free?(car, x, y - 1)
          new_node(color, x, y - 1,"Hore(#{get_color color}, #{car.y - y + 1})")
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

  def new_node(color, x, y, krok)
    tmp_cars = []
    cars.each {|c| tmp_cars.push(c.dup)}
    n = Node.new(parent: self, cars: tmp_cars)
    new_car = (n.cars.select {|ca| ca.color == color})[0]
    new_car.setx x
    new_car.sety y
    n.set_number
    n.change = krok
    children.push(n)
  end

  def get_color(int)
    if int == 1
      'cervene'
    elsif int == 2
      'oranzove'
    elsif int == 3
      'zlte'
    elsif int == 4
      'fialove'
    elsif int == 5
      'zelene'
    elsif int == 6
      'svetlomodre'
    elsif int == 7
      'sive'
    elsif int == 8
      'tmavomodre'
    end
  end

end

car1 = Car.new(color:1, length:2, x:1,y:2, direction:'x')
car2 = Car.new(color:2, length:2, x:0,y:0, direction:'x')
car3 = Car.new(color:3, length:3, x:0,y:1, direction:'y')
car4 = Car.new(color:4, length:2, x:0,y:4, direction:'y')
car5 = Car.new(color:5, length:3, x:3,y:1, direction:'y')
car6 = Car.new(color:6, length:3, x:2,y:5, direction:'x')
car7 = Car.new(color:7, length:2, x:4,y:4, direction:'x')
car8 = Car.new(color:8, length:3, x:5,y:0, direction:'y')

node = Node.new(parent:nil,cars:[car1,car2,car3,car4,car5,car6,car7,car8])

s = Search.new

node2 = s.bfs node

puts "......................."

s.dfs node

