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

  describe '#comission' do
    it 'calculates insurance_fee' do
      expect(rental.comission.insurance_fee).to eq(2116)
    end

    it 'calculates total_fee' do
      expect(rental.comission.total_fee).to eq(4233)
    end

    it 'calculates assistance_fee' do
      expect(rental.comission.assistance_fee).to eq(1000)
    end

    it 'calculates drivy_fee' do
      expect(rental.comission.drivy_fee).to eq(1117)
    end
  end

  describe '#price' do
    context 'when one day' do
      let(:rent_days) { 1 }

      it 'returns expected price' do
        expect(rental.price).to eq(2110)
      end
    end

    context 'when 3 days' do
      let(:rent_days) { 3 }

      it 'returns expected price' do
        expect(rental.price).to eq(5510)
      end
    end

    context 'when 7 days' do
      let(:rent_days) { 7 }

      it 'returns expected price' do
        expect(rental.price).to eq(9910)
      end
    end

    context 'when 11 days' do
      let(:rent_days) { 11 }

      it 'returns expected price' do
        expect(rental.price).to eq(11_110)
      end
    end
  end

  it_behaves_like 'rental model'
end
