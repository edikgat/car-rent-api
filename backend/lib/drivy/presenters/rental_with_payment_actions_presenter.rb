# frozen_string_literal: true

module Drivy
  class RentalWithPaymentActionsPresenter < BasePresenter
    def self.represent_for(rental)
      {
        id: rental.id,
        actions: [
          rental.payment_actions.driver,
          rental.payment_actions.owner,
          rental.payment_actions.insurance,
          rental.payment_actions.assistance,
          rental.payment_actions.drivy
        ]
      }
    end
  end
end
