# frozen_string_literal: true

describe Drivy::FlatPriceScaleRentalsController do
  describe '.rentals' do
    subject(:rentals) do
      described_class.rentals(
        input_path: input_path,
        output_path: output_path
      )
    end

    let(:options_array) { [] }
    let(:expected_output_hash) do
      {
        rentals: [
          {
            id: 1,
            price: 7000
          }
        ]
      }
    end

    it_behaves_like 'rentals controller'
  end
end
