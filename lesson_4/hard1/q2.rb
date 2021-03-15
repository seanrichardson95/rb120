# Ben and Alyssa are working on a vehicle management system. So far, they have created classes called Auto and Motorcycle to represent automobiles and motorcycles. After having noticed common information and calculations they were performing for each type of vehicle, they decided to break out the commonality into a separate class called WheeledVehicle. This is what their code looks like so far:

module Fuelable
  # attr_reader :fuel_capacity, :fuel_efficiency
  
  def assign_fuel_data(km_traveled_per_liter, liters_of_fuel_capacity)
    @fuel_efficiency = km_traveled_per_liter
    @fuel_capacity = liters_of_fuel_capacity
  end
  
  def range
    @fuel_capacity * @fuel_efficiency
  end
end

class WheeledVehicle
  include Fuelable
  
  attr_accessor :speed, :heading

  def initialize(tire_array, km_traveled_per_liter, liters_of_fuel_capacity)
    @tires = tire_array #wheels
    assign_fuel_data(km_traveled_per_liter, liters_of_fuel_capacity)
  end

  def tire_pressure(tire_index) #wheels
    @tires[tire_index]
  end

  def inflate_tire(tire_index, pressure) #wheels
    @tires[tire_index] = pressure
  end

end

class Auto < WheeledVehicle
  def initialize
    # 4 tires are various tire pressures
    super([30,30,32,32], 50, 25.0)
  end
end

class Motorcycle < WheeledVehicle
  def initialize
    # 2 tires are various tire pressures
    super([20,20], 80, 8.0)
  end
end

# Now Alan has asked them to incorporate a new type of vehicle into their system - a Catamaran defined as follows:

class SeaCraft
  include Fuelable
  
  attr_reader :propeller_count, :hull_count
  attr_accessor :speed, :heading
  
  def initialize(num_propellers, num_hulls, km_traveled_per_liter, liters_of_fuel_capacity)
    # ... code omitted ...
    assign_fuel_data(km_traveled_per_liter, liters_of_fuel_capacity)
  end
  
  def range
    super + 10
  end
  
end

class Catamaran < SeaCraft
end

class Motorboat < SeaCraft
  def initialize(km_traveled_per_liter, liters_of_fuel_capacity)
    super(1, 1, km_traveled_per_liter, liters_of_fuel_capacity)
  end
end

hotty = Motorboat.new(3, 5)
puts hotty.range