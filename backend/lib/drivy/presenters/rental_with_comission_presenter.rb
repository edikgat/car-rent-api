# frozen_string_literal: true

module Drivy
  class RentalWithComissionPresenter < RentalPresenter
    def self.represent_for(rental)
      super.merge(
        commission: RentalComissionPresenter.represent_for(rental.price_details)
      )
    end
  end
end
