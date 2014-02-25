require './Line.rb'
class QuickHull
  def self.convex_hull(points)
    if points.empty? then return [] end
    x = maxx(points)    
    p x
    y = maxy(points)
    p y
    convex_hull_rec(points, x, y)    
  end

  private
  def self.convex_hull_rec(points, l, r)
    if points.empty? then return [] end 
    if points == [l,r] or points == [r,l] then return [l,r] end
    x = maxx(points)
    y = maxy(points)
    z = max_from_line(points, Line.new(x,y))
    a = right_of_line(points, Line.new(x,z))
    b = left_of_line(points, Line.new(z,y))
    return (convex_hull_rec(a,x,z) + [z] + convex_hull_rec(b,z,y))
  end 

  def self.maxx(points)
    m = points.first
    points.each do |p|
      if p[0] > m[0]
        m = p
      elsif p[0] == m[0]
        if p[1] > p[1]
          m = p
        end
      end
    end
    return m
  end

  def self.maxy(points)
    m = points.first
    points.each do |p| 
      if p[1] > m[1]
        m = p
      elsif p[1] == m[1]
        if p[0] > p[0]
          m = p
        end
      end
    end
    return m
  end

  def self.max_from_line(points, line)
    max  = points.first
    dmax = distance(line, points.first)
    points.each do |p|  
      d = distance(line,p)
      if d > dmax
         max = p      
         dmax = d
      end
    end
    return max
  end

  def self.distance(line, point) 
    a = point[0] * (line.p2[1] - line.p1[1]) + (line.p1[0] - line.p2[0]) * point[1] - (line.p1[0] * line.p2[1] - line.p2[0] * line.p1[1])
    b = (line.p2[1] - line.p1[1])**2 + (line.p1[0] - line.p2[0])**2
    return a.abs/Math.sqrt(b)
  end
  
  def self.right_of_line(points, line)
    g = []
    points.each do |p|
      if side(line, p) == 1 then g << p end
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


a = [[2,1],[3,2],[3,3],[4,1]]
p a
p QuickHull.convex_hull(a).sort

