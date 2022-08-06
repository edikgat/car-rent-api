# frozen_string_literal: true

require_relative '../lib/drivy'

Drivy::DiscountedPriceScaleRentalsController.rentals(
  input_path: 'data/input.json',
  output_path: 'data/output.json'
)
