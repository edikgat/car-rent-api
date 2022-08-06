# frozen_string_literal: true

module Drivy
  class CarsBuilder
    def self.build_for(cars_data)
      new(cars_data).build
    end

    def initialize(cars_data)
      @cars_data = cars_data
    end

    def build
      cars_data.each do |car_data|
        Drivy::Car.create(
          id: car_data['id'],
          price_per_day: car_data['price_per_day'],
          price_per_km: car_data['price_per_km']
        )
      end
    end

    private

    attr_reader :cars_data

    private_class_method :new
  end
end
