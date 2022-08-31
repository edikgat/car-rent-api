# frozen_string_literal: true

module Drivy
  class FlatPriceScaleRentalsController < BaseController
    class << self
      def rentals(input_path:, output_path:)
        process_files(input_path, output_path) do |params|
          CarsBuilder.build_for(params['cars'])
          RentalsBuilder.build_for(params['rentals'], rental_class: FlatPriceScaleRental)

          RentalsView.represent_for(RentalsRepository.all, with: RentalPresenter)
        end
      end
    end
  end
end
