# frozen_string_literal: true

require_relative 'flat_scale_rental_price'

module Drivy
  class DiscountedScaleRentalPrice < FlatScaleRentalPrice
    ONE_DAY_PRICE_PROPORTION = 0.9
    FOUR_DAYS_PRICE_PROPORTION = 0.7
    TEN_DAYS_PRICE_PROPORTION = 0.5

    private

    def day_price
      base_day_price = super

      if rent_days > 10
        base_day_price * TEN_DAYS_PRICE_PROPORTION
      elsif rent_days > 4
        base_day_price * FOUR_DAYS_PRICE_PROPORTION
      elsif rent_days > 1
        base_day_price * ONE_DAY_PRICE_PROPORTION
      else
        base_day_price
      end
    end

    private_constant :ONE_DAY_PRICE_PROPORTION,
                     :FOUR_DAYS_PRICE_PROPORTION,
                     :TEN_DAYS_PRICE_PROPORTION
  end
end
