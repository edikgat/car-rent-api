# frozen_string_literal: true

module Drivy
  class RentalPaymentActions
    DRIVER_ACTION = :driver
    DRIVER_ACTION_TYPE = :debit

    OWNER_ACTION = :owner
    OWNER_ACTION_TYPE = :credit

    INSURANCE_ACTION = :insurance
    INSURANCE_ACTION_TYPE = :credit

    ASSISTANCE_ACTION = :assistance
    ASSISTANCE_ACTION_TYPE = :credit

    DRIVY_ACTION = :drivy
    DRIVY_ACTION_TYPE = :credit

    def initialize(price_details)
      @price_details = price_details
    end

    def driver
      {
        who: DRIVER_ACTION,
        type: DRIVER_ACTION_TYPE,
        amount: price_details.total_price
      }
    end

    def owner
      {
        who: OWNER_ACTION,
        type: OWNER_ACTION_TYPE,
        amount: price_details.owner_payment
      }
    end

    def insurance
      {
        who: INSURANCE_ACTION,
        type: INSURANCE_ACTION_TYPE,
        amount: price_details.insurance_fee
      }
    end

    def assistance
      {
        who: ASSISTANCE_ACTION,
        type: ASSISTANCE_ACTION_TYPE,
        amount: price_details.assistance_fee
      }
    end

    def drivy
      {
        who: DRIVY_ACTION,
        type: DRIVY_ACTION_TYPE,
        amount: price_details.drivy_fee
      }
    end

    private

    attr_reader :price, :price_details

    private_constant :DRIVER_ACTION,
                     :DRIVER_ACTION_TYPE,
                     :OWNER_ACTION,
                     :OWNER_ACTION_TYPE,
                     :INSURANCE_ACTION,
                     :INSURANCE_ACTION_TYPE,
                     :ASSISTANCE_ACTION,
                     :ASSISTANCE_ACTION_TYPE,
                     :DRIVY_ACTION,
                     :DRIVY_ACTION_TYPE
  end
end
