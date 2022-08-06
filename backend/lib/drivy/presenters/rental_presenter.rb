# frozen_string_literal: true

module Drivy
  class RentalPresenter
    def self.represent_for(rental)
      {
        id: rental.id,
        price: rental.price
      }
    end
  end
end
