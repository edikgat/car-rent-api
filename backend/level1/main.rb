# frozen_string_literal: true

require_relative '../lib/drivy'

Drivy::FlatPriceScaleRentalsController.rentals(
  input_path: 'data/input.json',
  output_path: 'data/output.json'
)
