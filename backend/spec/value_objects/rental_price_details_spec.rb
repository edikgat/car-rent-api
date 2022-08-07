# frozen_string_literal: true

describe Drivy::RentalPriceDetails do
  subject(:price_details) do
    described_class.new(
      price_per_day: price_per_day,
      price_per_km: price_per_km,
      distance: distance,
      rent_days: rent_days,
      option_types: option_types,
      price_calculator_class: price_calculator_class
    )
  end

  let(:price_calculator_class) { Drivy::FlatScaleRentalPrice }
  let(:price_per_day) { 2000 }
  let(:price_per_km) { 10 }

  context 'when 1 rent day & 100 km distance' do
    let(:rent_days) { 1 }
    let(:distance) { 100 }

    context 'when options are blank' do
      let(:option_types) { [] }

      it 'returns total price' do
        expect(price_details.total_price).to eq(3000)
      end

      it 'returns owner_payment' do
        expect(price_details.owner_payment).to eq(2100)
      end

      it 'calculates insurance_fee' do
        expect(price_details.insurance_fee).to eq(450)
      end

      it 'calculates assistance_fee' do
        expect(price_details.assistance_fee).to eq(100)
      end

      it 'calculates drivy_fee' do
        expect(price_details.drivy_fee).to eq(350)
      end
    end

    context 'when gps and baby_seat options are selected' do
      let(:option_types) { %w[gps baby_seat] }

      it 'returns total price' do
        expect(price_details.total_price).to eq(3700)
      end

      it 'returns owner_payment' do
        expect(price_details.owner_payment).to eq(2800)
      end

      it 'calculates insurance_fee' do
        expect(price_details.insurance_fee).to eq(450)
      end

      it 'calculates assistance_fee' do
        expect(price_details.assistance_fee).to eq(100)
      end

      it 'calculates drivy_fee' do
        expect(price_details.drivy_fee).to eq(350)
      end
    end
  end

  context 'when 2 rent days & 280 km distance' do
    let(:rent_days) { 2 }
    let(:distance) { 280 }

    context 'when options are blank' do
      let(:option_types) { [] }

      it 'returns total price' do
        expect(price_details.total_price).to eq(6800)
      end

      it 'returns owner_payment' do
        expect(price_details.owner_payment).to eq(4760)
      end

      it 'calculates insurance_fee' do
        expect(price_details.insurance_fee).to eq(1020)
      end

      it 'calculates assistance_fee' do
        expect(price_details.assistance_fee).to eq(200)
      end

      it 'calculates drivy_fee' do
        expect(price_details.drivy_fee).to eq(820)
      end
    end

    context 'when additional_insurance is selected' do
      let(:option_types) { ['additional_insurance'] }

      it 'returns total price' do
        expect(price_details.total_price).to eq(8800)
      end

      it 'returns owner_payment' do
        expect(price_details.owner_payment).to eq(4760)
      end

      it 'calculates insurance_fee' do
        expect(price_details.insurance_fee).to eq(1020)
      end

      it 'calculates assistance_fee' do
        expect(price_details.assistance_fee).to eq(200)
      end

      it 'calculates drivy_fee' do
        expect(price_details.drivy_fee).to eq(2820)
      end
    end
  end
end
