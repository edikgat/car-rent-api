# frozen_string_literal: true

describe Drivy::RentalWithPaymentActionsPresenter do
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
        price_per_day: 2000,
        price_per_km: 20
      )
    end

    it 'represents rental and actions data' do
      expect(presenter).to eq(
        id: 1,
        actions: [
          { who: :driver, type: :debit, amount: 3800 },
          { who: :owner, type: :credit, amount: 2660 },
          { who: :insurance, type: :credit, amount: 570 },
          { who: :assistance, type: :credit, amount: 200 },
          { who: :drivy, type: :credit, amount: 370 }
        ]
      )
    end
  end
end
