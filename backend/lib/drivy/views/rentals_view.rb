# frozen_string_literal: true

module Drivy
  class RentalsView
    def self.represent_for(collection, with:)
      { rentals: collection.map { |rental| with.represent_for(rental) } }
    end
  end
end
