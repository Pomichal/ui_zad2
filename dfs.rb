Map_x = 6 - 1  #x size of the map
Map_y = 6 - 1 #y size of the map

require 'set'

class Search
  ##breadt-first search 0, deep first search 1
  def searching(source, type, depth)
    nodes_count = 0
    open_set = []
    closed_set = Set.new

    open_set.push(source)

    while not open_set.empty? #main loop
      node = open_set.shift #get the first node from queue

      if goal?(node)        #if reached the goal, finish and print the result
        puts "Prehladanych uzlov: #{nodes_count}"
        return print_result node
      end

      node.set_children  #searching after next moves
      node.children.each do |child|
        if(closed_set.add? child.number)      #adding new nodes, (duplicates don't)
          open_set.push(child) if type == 0     #bfs: adding to end of the queue
          if type == 1  #dfs: adding to beginning of the queue
            if node.depth < depth
            open_set.unshift(child)
            end
          end
          nodes_count += 1
        end
      end
    end
    #if no result found
    puts "Prehladanych uzlov: #{nodes_count}"
    puts "riesenie neexistuje"
    nil
  end

  #returns true, if goal is reached (the red car is on coordinates 4,3 and 5,3)
  def goal?(node)
    new_car = (node.cars.select {|car| car.color == 1})[0]
    return true if(new_car.x == Map_x - new_car.length + 1)
    false
  end

  #prints the steps to result
  def print_result(node)
    steps = 0
    result = []
    while node.change != ""
      result.unshift node.change
      node = node.parent
      steps += 1
    end
    result.each do |z|
      puts z
    end
    puts "Pocet krokov: #{steps}"
    steps
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

  def is_there?(x,y)     #return true, if car is on position x y
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
  attr_accessor :parent, :children, :cars, :number, :change, :depth

  def initialize(options = {})
    @parent = options[:parent]
    @children = []
    @cars = options[:cars]
    @number = 0
    @change = ""
    @depth = 0
  end

  def set_number #number representing the places of cars on table
    tmp = @depth
    cars.each do |car|
      tmp += (10 ** car.color) * (car.x + car.y)
    end
    @number = tmp
  end

  def set_children #find all possibly next moves
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

  def is_free?(car,x,y) #returns true, if place x y is free
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

  def new_node(color, x, y, krok) #creates a children node
    tmp_cars = []
    cars.each {|c| tmp_cars.push(c.dup)}
    n = Node.new(parent: self, cars: tmp_cars)
    new_car = (n.cars.select {|ca| ca.color == color})[0]
    new_car.setx x
    new_car.sety y
    n.depth = self.depth + 1
    n.set_number
    n.change = krok
    children.push(n)
  end

  def get_color(int) #changes numbers to colors
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
# node.set_children
#
# node.children.each do |child|
#   puts child.change
#   child.cars.each do |c|
#     puts node.get_color(c.color).to_s + ' ' + (c.x + 1).to_s + ' ' + (c.y + 1).to_s
#   end
#   puts "#######################"
# end
#
# puts node.children.length.to_s
#
s = Search.new

x = 1
until s.searching node, 1, x
  x += 1
end