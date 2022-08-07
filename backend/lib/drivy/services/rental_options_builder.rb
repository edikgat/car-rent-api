# frozen_string_literal: true

module Drivy
  class RentalOptionsBuilder
    def self.build_for(rental_options_data)
      new(rental_options_data).build
    end

    def initialize(rental_options_data)
      @rental_options_data = rental_options_data
    end

    def build
      rental_options_data.each do |rental_option_data|
        RentalOption.create(
          id: rental_option_data['id'],
          rental_id: rental_option_data['rental_id'],
          type: rental_option_data['type']
        )
      end
    end

    private

    attr_reader :rental_options_data

    private_class_method :new
  end
end
