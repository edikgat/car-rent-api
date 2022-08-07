# frozen_string_literal: true

module Drivy
  class DiscountedPriceScaleRentalsController < BaseController
    class << self
      def rentals(input_path:, output_path:)
        process_rentals_with(input_path, output_path, presenter: RentalPresenter)
      end

      def rentals_with_comission(input_path:, output_path:)
        process_rentals_with(input_path, output_path, presenter: RentalWithComissionPresenter)
      end

      def rentals_with_payment_actions(input_path:, output_path:)
        process_rentals_with(input_path, output_path, presenter: RentalWithPaymentActionsPresenter)
      end

      private

      def process_rentals_with(input_path, output_path, presenter:)
        process_files(input_path, output_path) do |params|
          CarsBuilder.build_for(params['cars'])
          RentalsBuilder.build_for(params['rentals'], rental_class: DiscountedPriceScaleRental)

          RentalsView.represent_for(RentalsRepository.all, with: presenter)
        end
      end
    end
  end
end
