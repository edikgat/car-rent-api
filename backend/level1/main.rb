# frozen_string_literal: true

require_relative '../lib/drivy'

Drivy::RentalsController.save_rentals(
  input_path: 'data/input.json',
  output_path: 'data/output.json'
)
