# frozen_string_literal: true

module Drivy
  class RentalsRepository < BaseRepository
    private

    def instance_class
      BaseRental
    end
  end
end
