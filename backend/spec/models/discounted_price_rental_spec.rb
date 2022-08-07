# frozen_string_literal: true

describe Drivy::DiscountedPriceScaleRental do
  subject(:rental) { described_class.new(model_data) }

  let(:model_data) do
    {
      id: id,
      car_id: car_id,
      start_date: start_date,
      end_date: end_date,
      distance: distance
    }
  end
  let(:id) { 1 }
  let(:car_id) { 1 }
  let(:distance) { 11 }
  let(:start_date) { Date.today }
  let(:end_date) { Date.today + rent_days - 1 }
  let(:rent_days) { 10 }

  before do
    Drivy::Car.create(
      id: 1,
      price_per_day: 2000,
      price_per_km: 10
    )
  end

  describe '#price_details' do
    it 'calculates fee' do
      expect(rental.price_details.total_fee).to eq(4233)
    end
  end

  describe '#price' do
    let(:rent_days) { 1 }

    it 'returns expected price' do
      expect(rental.price).to eq(2110)
    end
  end

  describe '#payment_actions' do
    it 'returns payment actions' do
      expect(rental.payment_actions.driver).to eq(
        amount: 14_110,
        type: :debit,
        who: :driver
      )
    end
  end

  it_behaves_like 'rental model'
end
