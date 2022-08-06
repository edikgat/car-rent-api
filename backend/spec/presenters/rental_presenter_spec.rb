# frozen_string_literal: true

describe Drivy::RentalPresenter do
  describe '.represent_for' do
    subject(:presenter) { described_class.represent_for(rental) }

    let(:rental) do
      Drivy::Rental.new(
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
        price_per_day: 100,
        price_per_km: 2
      )
    end

    it 'represents rental data' do
      expect(presenter).to eq({ id: 1, price: 220 })
    end
  end
end
