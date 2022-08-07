# frozen_string_literal: true

describe Drivy::RentalWithOptionsAndPaymentActionsPresenter do
  describe '.represent_for' do
    subject(:presenter) { described_class.represent_for(rental) }

    let(:rental) do
      Drivy::DiscountedPriceScaleRental.create(
        id: 1,
        car_id: 1,
        start_date: Date.today,
        end_date: Date.today,
        distance: 100
      )
    end

    before do
      Drivy::Car.create(
        id: 1,
        price_per_day: 2000,
        price_per_km: 10
      )
      rental
      Drivy::RentalOption.create(
        id: 1,
        rental_id: 1,
        type: 'gps'
      )
      Drivy::RentalOption.create(
        id: 2,
        rental_id: 1,
        type: 'baby_seat'
      )
    end

    it 'represents rental, options and actions data' do
      expect(presenter).to eq(
        id: 1,
        actions: [{ who: :driver, type: :debit, amount: 3700 },
                  { who: :owner, type: :credit, amount: 2800 },
                  { who: :insurance, type: :credit, amount: 450 },
                  { who: :assistance, type: :credit, amount: 100 },
                  { who: :drivy, type: :credit, amount: 350 }],
        options: %w[gps baby_seat]
      )
    end
  end
end
