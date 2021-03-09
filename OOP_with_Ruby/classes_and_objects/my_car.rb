class MyCar
  attr_accessor :color
  attr_reader :year
  
  def initialize(y, c, m)
    @year = y
    @color = c
    @model = m
    @speed = 0
  end
  
  def speed_up(more_mph)
    @speed += more_mph
    puts "You push the gas and accelerate #{more_mph} mph."
  end
  
  def brake(less_mph)
    @speed -= less_mph
    puts "You push the brake and decelerate #{less_mph} mph."
  end
  
  def current_speed
    puts "You are now going #{@speed} mph."
  end
  
  def shutoff
    @speed = 0
    puts "Let's park this bad boy!"
  end
  
  def spray_paint(new_color)
    self.color = new_color
  end
  
  def self.gas_mileage(gallons, miles)
    @@mpg = miles / gallons
    puts "#{@@mpg} miles per gallon of gas"
  end
  
  def to_s
    "This car is a #{year} #{color} #{@model}."
  end
  
end

MyCar.gas_mileage(13, 351)
dyani = MyCar.new(2018, "white", "Elantra")
puts dyani
# dyani.speed_up(25)
# dyani.current_speed
# dyani.brake(5)
# dyani.current_speed
# dyani.shutoff
# dyani.current_speed
# puts dyani.year
# dyani.spray_paint("blue")
# puts dyani.color

