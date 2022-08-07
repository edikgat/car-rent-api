# frozen_string_literal: true

describe Drivy::DiscountedPriceScaleRentalsController do
  describe '.rentals' do
    subject(:rentals) do
      described_class.rentals(
        input_path: input_path,
        output_path: output_path
      )
    end

    let(:expected_output_hash) do
      {
        rentals: [
          {
            id: 1,
            price: 6400
          }
        ]
      }
    end

    it_behaves_like 'rentals controller'
  end

  describe '.rentals_with_comission' do
    subject(:rentals) do
      described_class.rentals_with_comission(
        input_path: input_path,
        output_path: output_path
      )
    end

    let(:expected_output_hash) do
      {
        rentals: [
          {
            id: 1,
            price: 6400,
            commission: {
              insurance_fee: 960,
              assistance_fee: 300,
              drivy_fee: 660
            }
          }
        ]
      }
    end

    it_behaves_like 'rentals controller'
  end

  describe '.rentals_with_payment_actions' do
    subject(:rentals) do
      described_class.rentals_with_payment_actions(
        input_path: input_path,
        output_path: output_path
      )
    end

    let(:expected_output_hash) do
      { rentals: [{ id: 1,
                    actions: [{ who: :driver, type: :debit, amount: 6400 },
                              { who: :owner, type: :credit, amount: 4480 },
                              { who: :insurance, type: :credit, amount: 960 },
                              { who: :assistance, type: :credit, amount: 300 },
                              { who: :drivy, type: :credit, amount: 660 }] }] }
    end

    it_behaves_like 'rentals controller'
  end
end
