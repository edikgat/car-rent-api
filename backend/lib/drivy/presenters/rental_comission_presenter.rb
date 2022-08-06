# frozen_string_literal: true

module Drivy
  class RentalComissionPresenter < BasePresenter
    def self.represent_for(comission)
      {
        insurance_fee: comission.insurance_fee,
        assistance_fee: comission.assistance_fee,
        drivy_fee: comission.drivy_fee
      }
    end
  end
end
