# frozen_string_literal: true

require_relative '../lib/drivy'

Drivy::DiscountedPriceScaleRentalsController.rentals_with_comission(
  input_path: 'data/input.json',
  output_path: 'data/output.json'
)
