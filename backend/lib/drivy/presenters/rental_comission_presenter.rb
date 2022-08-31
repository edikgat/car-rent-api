# frozen_string_literal: true

module Drivy
  class RentalComissionPresenter < BasePresenter
    def self.represent_for(price_details)
      {
        insurance_fee: price_details.insurance_fee,
        assistance_fee: price_details.assistance_fee,
        drivy_fee: price_details.drivy_fee
      }
    end
  end
end
