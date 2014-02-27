class GraphHull
  def self.graph(points, hull, name)
    require 'gruff'
  
    points = points - hull
      px = []
      py = []
      hx = []
      hy = []
    if !points.empty? 

      points.each do |p|
        px << p[0]
        py << p[1]
      end

      hull.each do |p|
        hx << p[0]
        hy << p[1]
      end

      @datasets = [
              [:hull,hx, hy],
              [:points, px, py]
          ]


      g=Gruff::Scatter.new(800)
      g.title = name
      @datasets.each do |data|
        g.data(data[0], data[1], data[2])
      end

      g.write(name + '.png')
    else
      hull.each do |p|
        hx << p[0]
        hy << p[1]
      end

      @datasets = [
              [:hull,hx, hy],
          ]


      g=Gruff::Scatter.new(800)
      g.title = name
      @datasets.each do |data|
        g.data(data[0], data[1], data[2])
      end

      g.write(name + '.png')
    end
  end
end
