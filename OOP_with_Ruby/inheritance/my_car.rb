require 'time'

module Americanable
  def home_country
    "I'm from 'Merica! Yee haw!!!"
  end
end


class Vehicle
  attr_accessor :color
  attr_reader :year, :model
  
  @@num_of_vehicles = 0
  
  def initialize(y, c, m)
    @year = y
    @color = c
    @model = m
    @speed = 0
    @@num_of_vehicles += 1
  end
  
  def self.num_of_vehicles
    words = @@num_of_vehicles == 1 ? "vehicle has" : "vehicles have"
    puts "#{@@num_of_vehicles} #{words} been created so far."
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

  def age
    "Your #{self.model} is #{calculate_age} years old"
  end

  private
  
  def calculate_age
    Time.now.year - self.year
  end
end

class MyCar < Vehicle
  
  CAR_DETAILS = {cargo_bed: false, doors: 4}
  
  def to_s
    "This car is a #{year} #{color} #{@model}."
  end
  
end

class MyTruck < Vehicle
  include Americanable
  TRUCK_DETAILS = {cargo_bed: true, doors: 2}
end


MyCar.gas_mileage(13, 351)
dyani = MyCar.new(2018, "white", "Elantra")
dad = MyTruck.new(2005, "red", "Cherokee")
Vehicle.num_of_vehicles
puts dad.home_country
dad.age
# puts "--MyCar ancestors--"
# puts MyCar.ancestors
# puts "\n--MyTruck ancestors--"
# puts MyTruck.ancestors
# puts "\n--Vehicle ancestors--"
# puts Vehicle.ancestors
dyani.speed_up(25)
dyani.current_speed
dyani.brake(5)
dyani.current_speed
dyani.shutoff
dyani.current_speed
puts dyani.year
dyani.spray_paint("blue")
puts dyani.color

