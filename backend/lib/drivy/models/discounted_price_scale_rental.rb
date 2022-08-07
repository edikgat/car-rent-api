# frozen_string_literal: true

module Drivy
  class DiscountedPriceScaleRental < BaseRental
    def price_calculator_class
      DiscountedScaleRentalPrice
    end
  end
end
