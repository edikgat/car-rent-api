# frozen_string_literal: true

module Drivy
  class RentalOption < BaseModel
    AVAILABLE_TYPES = [
      GPS = 'gps',
      BABY_SEAT = 'baby_seat',
      ADDITIONAL_INSURANCE = 'additional_insurance'
    ].freeze
    SINGLE_ADDITIONAL_INSURANCE_ERROR_MESSAGE = 'allowed just one additional insurance per reservation'

    attr_reader :id, :rental_id, :type

    belongs_to :rental, class_name: 'BaseRental'

    def initialize(id:, rental_id:, type:)
      @id = id
      @rental_id = rental_id
      @type = type
    end

    def valid?
      validates_presence_of :id
      validates_presence_of :rental_id
      validates_presence_of :type

      validates_positive_integer_of :id
      validates_positive_integer_of :rental_id

      validates_presence_of :rental
      validates_uniqueness_of :id

      validates_inclusion_of :type, options: AVAILABLE_TYPES
      validate_single_additional_insurance
      true
    end

    private

    def validate_single_additional_insurance
      repository.any? do |model|
        model != self &&
          model.rental_id == rental_id &&
          model.type == type &&
          type == ADDITIONAL_INSURANCE
      end && raise_validation_error(:type, SINGLE_ADDITIONAL_INSURANCE_ERROR_MESSAGE)
    end
  end
end
