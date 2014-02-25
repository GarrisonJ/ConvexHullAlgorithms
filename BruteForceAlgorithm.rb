require './AndrewMonotoneChain.rb'
require 'benchmark'
require 'rubyvis'
require './graph.rb'
require './Line.rb'

class BruteForceConvexHull
  def self.convex_hull(points)
    conSet = []
    points.uniq!
    points.each do |i|
      points.each do |j|
        if !(i.equal?(j))
          l = Line.new(i, j)
          side = nil
          goodLine = true
          points.each do |k|
            if !(i.equal?(k) or j.equal?(k))
              rightSide = right_side(l,k)
              if side == nil
                if rightSide != 0
                  side = rightSide
                end
              else 
                if !(((0<side) and (0<rightSide)) or ((0>side) and (0>rightSide)))
                  goodLine = false
                end 
              end
            end
          end
          if goodLine
            conSet << l.p1 
            conSet << l.p2
          end
        end
      end    
    end
    return conSet.uniq
  end 

  def self.right_side(line, point)
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
end # class end
