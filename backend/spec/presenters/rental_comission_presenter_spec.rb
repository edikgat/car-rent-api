# frozen_string_literal: true

describe Drivy::RentalComissionPresenter do
  describe '.represent_for' do
    subject(:presenter) { described_class.represent_for(comission) }

    let(:comission) do
      Drivy::RentalPriceDetails.new(
        rent_days: 1,
        option_types: [],
        price_per_day: 2000,
        price_per_km: 10,
        distance: 100,
        price_calculator_class: Drivy::DiscountedScaleRentalPrice
      )
    end

    it 'represents comission data' do
      expect(presenter).to eq(
        assistance_fee: 100,
        drivy_fee: 350,
        insurance_fee: 450
      )
    end
  end
end
