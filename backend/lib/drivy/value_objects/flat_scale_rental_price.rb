# frozen_string_literal: true

module Drivy
  class FlatScaleRentalPrice
    def self.calculate_for(price_per_day:, price_per_km:, rent_days:, distance:)
      new(
        price_per_day: price_per_day,
        price_per_km: price_per_km,
        rent_days: rent_days,
        distance: distance
      ).calculate
    end

    def initialize(price_per_day:, price_per_km:, rent_days:, distance:)
      @price_per_day = price_per_day
      @price_per_km = price_per_km
      @rent_days = rent_days
      @distance = distance
    end

    def calculate
      (day_price + distance_price).to_i
    end

    private

    def day_price
      rent_days * price_per_day
    end

    def distance_price
      distance * price_per_km
    end

    attr_reader :price_per_day, :price_per_km, :rent_days, :distance

    private_class_method :new
  end
end
