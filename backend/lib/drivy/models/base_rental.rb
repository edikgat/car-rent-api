# frozen_string_literal: true

module Drivy
  class BaseRental < BaseModel
    OVERBOOKING_ERROR_MESSAGE = 'Overbooking is not allowed'

    attr_reader :id, :car_id, :start_date, :end_date, :distance

    belongs_to :car

    def self.repository_class
      RentalsRepository
    end

    def initialize(id:, car_id:, start_date:, end_date:, distance:)
      @id = id
      @car_id = car_id
      @start_date = start_date
      @end_date = end_date
      @distance = distance
    end

    def rent_days
      (end_date - start_date).to_i + 1
    end

    def price
      raise NotImplementedError
    end

    def price_details
      @price_details ||= RentalPriceDetails.new(
        price: price,
        rent_days: rent_days
      )
    end

    def payment_actions
      @payment_actions ||= RentalPaymentActions.new(price_details)
    end

    def valid?
      validates_presence_of :id
      validates_presence_of :car_id
      validates_presence_of :start_date
      validates_presence_of :end_date
      validates_presence_of :distance

      validates_positive_integer_of :id
      validates_positive_integer_of :car_id
      validates_positive_integer_of :distance

      validates_date_of :start_date
      validates_date_of :end_date
      validates_positive_integer_of :rent_days

      validates_presence_of :car
      validates_uniqueness_of :id

      validate_overbooking
      true
    end

    private

    def validate_overbooking
      repository.any? do |model|
        model != self &&
          model.car_id == car_id &&
          (model.end_date.between?(start_date, end_date) ||
            model.start_date.between?(start_date, end_date))
      end && raise_validation_error(:id, OVERBOOKING_ERROR_MESSAGE)
    end
  end
end
