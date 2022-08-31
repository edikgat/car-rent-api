# frozen_string_literal: true

module Drivy
  class Car < BaseModel
    PRICE_PER_DATE_VALUE_ERROR_MESSAGE = 'Should be more than or equal to 100'

    attr_reader :id, :price_per_day, :price_per_km

    has_many :rentals, class_name: 'BaseRental', foreign_key: 'car_id'

    def initialize(id:, price_per_day:, price_per_km:)
      @id = id
      @price_per_day = price_per_day
      @price_per_km = price_per_km
    end

    def valid?
      validates_presence_of :id
      validates_presence_of :price_per_day
      validates_presence_of :price_per_km

      validates_positive_integer_of :id
      validates_positive_integer_of :price_per_day
      validates_positive_integer_of :price_per_km

      validates_uniqueness_of :id
      validate_price_per_day_value

      true
    end

    private

    def validate_price_per_day_value
      price_per_day < 100 &&
        raise_validation_error(:price, PRICE_PER_DATE_VALUE_ERROR_MESSAGE)
    end
  end
end
