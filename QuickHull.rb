require './Line.rb'
require './Graph.rb'
require './AndrewMonotoneChain.rb'
class QuickHull
  def self.convex_hull(points)
    @points = points
    if points.empty? then return [] end
    min = minx(points)
    max = maxx(points)
    r = right_of_line(points, Line.new(min, max))
    l = left_of_line(points, Line.new(min, max)) 
    return convex_hull_rec(r, min, max) + [min, max] + convex_hull_rec(l, max, min)
  end

  def self.convex_hull_rec(points, l, r)
    if points.empty? then return [] end
    z = max_from_line(points, Line.new(l, r))  
    a = right_of_line(points, Line.new(l, z))
    b = right_of_line(points, Line.new(z, r))
    return convex_hull_rec(a, l, z) + [z] + convex_hull_rec(b, z, r)
  end 

  def self.maxx(points)
    maxP = points.first
    points.each do |p|
      if p[0] > maxP[0]
        maxP = p
      elsif p[0] == maxP[0]
        if p[1] > maxP[1]
          maxP = p
        end
      end
    end
    return maxP
  end

  def self.minx(points)
    minP = points.first
    points.each do |p|
      if p[0] < minP[0]
        minP = p
      elsif p[0] == minP[0]
        if p[1] < minP[1]
          minP = p
        end
      end
    end
    return minP
  end

  def self.max_from_line(points, line)
    point = []
    max = 0
    points.each do |p|
      t = ((line.p1[0] - p[0]) * (line.p2[1] - line.p1[1]) - (line.p1[0] - line.p2[0]) * (p[1] - line.p1[1])).abs
      if max < t
        max = t
        point = [p]
      elsif max == t
        point << p
      end
      
    end
    return minx(point)
  end
  
  def self.right_of_line(points, line)
    g = []
    points.each do |p|
      if (side(line, p) == 1) then g << p end
    end
    return g
  end

  def self.left_of_line(points, line)
    g = []
    points.each do |p|
      if side(line, p) == -1 then g << p end
    end
    return g
  end

  def self.side(line, point)
  # Return -1 0 or 1
    a = point[0] * (line.p2[1] - line.p1[1]) + (line.p1[0] - line.p2[0]) * point[1] - (line.p1[0] * line.p2[1] - line.p2[0] * line.p1[1])
    if a < 0
      return -1
    elsif a > 0
      return 1
    else
      return 0
    end
  end
end

(1000).times do 
  a = Array.new(100) { Array.new(2) { rand(10) } }
  h = QuickHull.convex_hull(a)
  b = AndrewMonotoneChain.convex_hull(a)
  print '.'
  if !(h.sort==b.sort)
    puts "FALSE"
    GraphHull.graph(a,h,'QuickHull')
    GraphHull.graph(a,b,'Andrew')
    break
  end
end



