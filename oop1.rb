# frozen_string_literal: true

module Towable
  def can_tow?(pounds)
    pounds < 2000
  end
end

class Vehicle
  attr_accessor :color, :current_speed
  attr_reader :year, :model

  @@vehicles_created = 0

  def initialize(year, color, model)
    @@vehicles_created += 1
    @year = year
    @color = color
    @model = model
    @current_speed = 0
  end

  def speed_up(value)
    self.current_speed += value
    puts "The speed has been increased to #{@current_speed}!"
  end
  
  def brake(value)
    self.current_speed -= value
    puts "The speed has been decreased to #{@current_speed}!"
  end
  
  def shut_down
    puts 'The car has been turned off.'
  end
  
  def spray_paint(new_color)
    self.color = new_color
    puts "You sprayed a #{new_color} tint in your car."
  end
  
  def age
    puts "#{self.model} is #{calculate_age} years old."
  end
  
  def self.gas_mileage(liters, kilometers)
    puts "#{kilometers / liters} kilometers per liters of gas."
  end
  
  def self.vehicles_created
    puts "Vehicles created: #{@@vehicles_created}."
  end

  private

  def calculate_age
    Time.now.year - self.year.to_i
  end
end

class MyCar < Vehicle
  PASSENGERS = 5
  
  def to_s
    puts "My car is a #{color}, #{year}, #{model}!"
  end
end

class MyTruck < Vehicle
  include Towable

  PASSENGERS = 3
end

car = MyCar.new('2017', 'black', 'New Polo')
car.speed_up(100)
car.brake(20)
car.speed_up(50)
car.brake(100)
car.shut_down
car.color = 'white'
puts car.color
puts car.year
car.spray_paint('blue')
puts car.color
MyCar.gas_mileage(30, 200)
car.to_s
truck = MyTruck.new('2000', 'blue', 'Ford 2000')
Vehicle.vehicles_created
puts truck.can_tow?(1000)
truck.age
car.age