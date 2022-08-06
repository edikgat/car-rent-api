# frozen_string_literal: true

module Drivy
  class RentalPresenter < BasePresenter
    def self.represent_for(rental)
      {
        id: rental.id,
        price: rental.price
      }
    end
  end
end
