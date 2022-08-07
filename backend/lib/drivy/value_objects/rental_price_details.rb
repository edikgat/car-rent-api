# frozen_string_literal: true

module Drivy
  class RentalPriceDetails
    TOTAL_FEE_PROPORTION = 0.30
    INSURANCE_FEE_FROM_TOTAL_FEE_PROPORTION = 0.5

    def initialize(price:, rent_days:)
      @price = price
      @rent_days = rent_days
    end

    attr_reader :price

    def owner_payment
      price - total_fee
    end

    def total_fee
      (price * TOTAL_FEE_PROPORTION).to_i
    end

    def insurance_fee
      (total_fee * INSURANCE_FEE_FROM_TOTAL_FEE_PROPORTION).to_i
    end

    def assistance_fee
      100 * rent_days
    end

    def drivy_fee
      total_fee - insurance_fee - assistance_fee
    end

    private

    attr_reader :rent_days
  end
end
