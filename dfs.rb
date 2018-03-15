
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
#
# end

class Node
  attr_accessor :parent, :children, :cars

  Map_x = 6  #x size of the map
  Map_y = 6  #y size of the map

  def initialize(options = {})
    @parent = options[:parent]
    @children = []
    @cars = options[:cars]
  end

  def get_children
    self.cars.each do |car|
      x = car.x
      y = car.y

      if car.direction == 'x'
        find_direction('x',x,y,Map_x, car)
      elsif car.direction == 'y'
        find_direction('y',y,x,Map_y, car)
      end
    end
  end

  def find_direction(dir, var_cor, const_cor, map_var, car)
      while var_cor < map_var
        var_cor += 1
        find_child(dir,var_cor,const_cor, car)
      end
      while var_cor > 0
        var_cor -= 1
        find_child(dir,var_cor,const_cor, car)
      end
  end

  def find_child(dir, var_cor,const_cor, car)
    self.cars.each do |c|
      puts var_cor.to_s + ' ' + const_cor.to_s
      if(c != car and (not c.is_there?(var_cor, const_cor)))
        puts (c != car and (not c.is_there?(var_cor,const_cor)))
        n = Node.new(parent: self.parent, cars: self.cars.clone)
        new_car = (n.cars.select {|ca| ca.x == car.x and ca.y==car.y})[0]
        puts new_car.color.to_s + ' ' + new_car.x.to_s + ' ' + new_car.y.to_s
        new_car.setx(var_cor) if dir == 'x'
        new_car.sety(var_cor) if dir == 'y'
        self.children.push(n)
      end
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

car1 = Car.new(color:'cervene', length:2, x:1,y:2, direction:'x')
car2 = Car.new(color:'oranzove', length:2, x:0,y:0, direction:'x')
car3 = Car.new(color:'zlte', length:3, x:0,y:1, direction:'y')
car4 = Car.new(color:'fialove', length:2, x:0,y:4, direction:'y')
car5 = Car.new(color:'zelene', length:3, x:3,y:1, direction:'y')
car6 = Car.new(color:'svetlomodre', length:3, x:2,y:5, direction:'x')
car7 = Car.new(color:'sive', length:2, x:4,y:4, direction:'x')
car8 = Car.new(color:'tmavomodre', length:3, x:5,y:0, direction:'y')

#puts(car1.is_there?(1,2))
node = Node.new(parent:nil,cars:[car1,car2, car3, car4, car5, car6, car7, car8])

#puts car1.to_s
node.get_children
#node2 = Node.new(parent:node,cars:[car1,car2, car3, car4, car5, car6, car7, car8])
#node.children.push(node2)
node.children.each do |c|
  c.cars.each {|car| puts car.color.to_s + ' ' + car.x.to_s + ' ' + car.y.to_s}
  puts "###############"
end