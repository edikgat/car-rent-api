# frozen_string_literal: true

module Drivy
  class FlatPriceScaleRental < BaseRental
    def price_calculator_class
      FlatScaleRentalPrice
    end
  end
end
