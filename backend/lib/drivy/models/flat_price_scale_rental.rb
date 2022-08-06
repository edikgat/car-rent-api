# frozen_string_literal: true

module Drivy
  class FlatPriceScaleRental < BaseRental
    def price
      @price ||= FlatScaleRentalPrice.calculate_for(
        price_per_day: car.price_per_day,
        price_per_km: car.price_per_km,
        rent_days: rent_days,
        distance: distance
      )
    end
  end
end
