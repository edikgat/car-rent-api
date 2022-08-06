# frozen_string_literal: true

module Drivy
  class Car < BaseModel
    attr_reader :id, :price_per_day, :price_per_km

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
      true
    end
  end
end
