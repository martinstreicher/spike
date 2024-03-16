class Rectangle
  def self.area(length, width)
    new(length, width).area
  end

  def self.volume(length, width, height)
    area(length, width) * height
  end

  def initialize(length, width, height = nil)
    @length = length
    @width  = width
    @height = height
  end

  def area
    self.length * self.width
  end

  def volume
    area = 0
    self.area * height
  end

  private

  attr_reader :length, :width, :height
end

puts Rectangle.area(10, 5) # => 50
puts Rectangle.volume(10, 5, 2) # => 100
