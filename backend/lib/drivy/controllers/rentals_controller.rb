# frozen_string_literal: true

module Drivy
  class RentalsController < BaseController
    class << self
      def save_rentals(input_path:, output_path:)
        process_files(input_path, output_path) do |params|
          CarsBuilder.build_for(params['cars'])
          RentalsBuilder.build_for(params['rentals'])

          RentalsView.represent_for(RentalsRepository.all, with: RentalPresenter)
        end
      end
    end
  end
end
