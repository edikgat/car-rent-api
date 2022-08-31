# frozen_string_literal: true

module Drivy
  class RentalPriceDetails
    TOTAL_FEE_PROPORTION = 0.30
    INSURANCE_FEE_FROM_TOTAL_FEE_PROPORTION = 0.5
    ASSISTANCE_FEE_PER_DAY = 100

    GPS_PER_DAY_PRICE = 500
    BABY_SEAT_PER_DAY_PRICE = 200
    ADDITIONAL_INSURANCE_PER_DAY_PRICE = 1000

    def initialize(rent_days:,
                   option_types:,
                   price_per_day:,
                   price_per_km:,
                   distance:,
                   price_calculator_class:)
      @rent_days = rent_days
      @option_types = option_types
      @price_per_day = price_per_day
      @price_per_km = price_per_km
      @distance = distance
      @price_calculator_class = price_calculator_class
    end

    def total_price
      price_without_options + total_options_price
    end

    def owner_payment
      price_without_options - total_fee + gps_price + baby_seat_price
    end

    def insurance_fee
      (total_fee * INSURANCE_FEE_FROM_TOTAL_FEE_PROPORTION).to_i
    end

    def assistance_fee
      ASSISTANCE_FEE_PER_DAY * rent_days
    end

    def drivy_fee
      total_fee - insurance_fee - assistance_fee + additional_insurance_price
    end

    private

    def total_fee
      (price_without_options * TOTAL_FEE_PROPORTION).to_i
    end

    def total_options_price
      gps_price + baby_seat_price + additional_insurance_price
    end

    def gps_price
      GPS_PER_DAY_PRICE * rent_days * option_types.count(RentalOption::GPS)
    end

    def baby_seat_price
      BABY_SEAT_PER_DAY_PRICE * rent_days * option_types.count(RentalOption::BABY_SEAT)
    end

    def additional_insurance_price
      ADDITIONAL_INSURANCE_PER_DAY_PRICE * rent_days * option_types.count(RentalOption::ADDITIONAL_INSURANCE)
    end

    def price_without_options
      @price_without_options ||= price_calculator_class.calculate_for(
        price_per_day: price_per_day,
        price_per_km: price_per_km,
        rent_days: rent_days,
        distance: distance
      )
    end

    attr_reader :rent_days,
                :option_types,
                :price_per_day,
                :price_per_km,
                :distance,
                :price_calculator_class
  end
end
