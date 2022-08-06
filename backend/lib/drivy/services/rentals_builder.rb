# frozen_string_literal: true

module Drivy
  class RentalsBuilder
    DATE_PATTERN = '%Y-%m-%d'

    def self.build_for(rentals_data, rental_class:)
      new(rentals_data, rental_class).build
    end

    def initialize(rentals_data, rental_class)
      @rentals_data = rentals_data
      @rental_class = rental_class
    end

    def build
      rentals_data.each do |rental_data|
        rental_class.create(
          id: rental_data['id'],
          car_id: rental_data['car_id'],
          start_date: parse_date_for(rental_data['start_date']),
          end_date: parse_date_for(rental_data['end_date']),
          distance: rental_data['distance']
        )
      end
    end

    private

    def parse_date_for(date_string)
      date_string &&
        Date.strptime(date_string, DATE_PATTERN)
    end

    attr_reader :rentals_data, :rental_class

    private_class_method :new
  end
end
