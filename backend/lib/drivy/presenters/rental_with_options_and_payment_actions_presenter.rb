# frozen_string_literal: true

require_relative 'rental_with_payment_actions_presenter'

module Drivy
  class RentalWithOptionsAndPaymentActionsPresenter < RentalWithPaymentActionsPresenter
    def self.represent_for(rental)
      super.merge(
        options: rental.option_types
      )
    end
  end
end
