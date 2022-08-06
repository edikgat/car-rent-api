# frozen_string_literal: true

module Drivy
  class RentalsBuilder
    DATE_PATTERN = '%Y-%m-%d'

    def self.build_for(rentals_data)
      new(rentals_data).build
    end

    def initialize(rentals_data)
      @rentals_data = rentals_data
    end

    def build
      rentals_data.each do |rental_data|
        Drivy::Rental.create(
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

    attr_reader :rentals_data

    private_class_method :new
  end
end
