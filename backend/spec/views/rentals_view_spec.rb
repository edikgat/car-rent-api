# frozen_string_literal: true

describe Drivy::RentalsView do
  describe '.represent_for' do
    subject(:view) do
      described_class.represent_for(
        Drivy::RentalsRepository.all,
        with: Drivy::RentalPresenter
      )
    end

    before do
      Drivy::Car.create(
        id: 1,
        price_per_day: 100,
        price_per_km: 2
      )
      Drivy::FlatPriceScaleRental.create(
        id: 1,
        car_id: 1,
        start_date: Date.today,
        end_date: Date.today + 1,
        distance: 10
      )
    end

    it 'represents rentals data' do
      expect(view).to eq(
        rentals: [{ id: 1, price: 220 }]
      )
    end
  end
end
