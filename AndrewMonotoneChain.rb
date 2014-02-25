# This is not my algorithm, it was taken from this wiki page: 
# http://en.wikibooks.org/wiki/Algorithm_Implementation/Geometry/Convex_hull/Monotone_chain
class AndrewMonotoneChain
  def self.cross(o, a, b)
    (a[0] - o[0]) * (b[1] - o[1]) - (a[1] - o[1]) * (b[0] - o[0])
  end
  def self.convex_hull(pointss)
    points = pointss.dup
    points.sort!.uniq!
    return points if points.length < 3
    lower = Array.new
    points.each{|p|
      while lower.length > 1 and cross(lower[-2], lower[-1], p) <= 0 do lower.pop end
      lower.push(p)
    }
    upper = Array.new
    points.reverse_each{|p|
      while upper.length > 1 and cross(upper[-2], upper[-1], p) <= 0 do upper.pop end
      upper.push(p)
    }
    return lower[0...-1] + upper[0...-1]
  end
  fail unless convex_hull((0..9).to_a.repeated_permutation(2).to_a) == [[0, 0], [9, 0], [9, 9], [0, 9]]
end
