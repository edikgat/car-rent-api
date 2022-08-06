# frozen_string_literal: true

describe Drivy::RentalWithComissionPresenter do
  describe '.represent_for' do
    subject(:presenter) { described_class.represent_for(rental) }

    let(:rental) do
      Drivy::DiscountedPriceScaleRental.new(
        id: 1,
        car_id: 1,
        start_date: Date.today,
        end_date: Date.today + 1,
        distance: 10
      )
    end

    before do
      Drivy::Car.create(
        id: 1,
        price_per_day: 1000,
        price_per_km: 20
      )
    end

    it 'represents rental and comission data' do
      expect(presenter).to eq(
        id: 1,
        price: 2000,
        commission: {
          assistance_fee: 200,
          drivy_fee: 100,
          insurance_fee: 300
        }
      )
    end
  end
end
