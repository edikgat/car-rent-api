# frozen_string_literal: true

describe Drivy::DiscountedScaleRentalPrice do
  describe '.calculate_for' do
    subject(:calculator) do
      described_class.calculate_for(
        price_per_day: 300,
        price_per_km: 10,
        rent_days: rent_days,
        distance: 1000
      )
    end

    context 'when 1 rent day' do
      let(:rent_days) { 1 }

      it 'calculates price correctly' do
        expect(calculator).to eq(10_300)
      end
    end

    context 'when 3 rent days' do
      let(:rent_days) { 3 }

      it 'calculates price correctly' do
        expect(calculator).to eq(10_810)
      end
    end

    context 'when 5 rent days' do
      let(:rent_days) { 5 }

      it 'calculates price correctly' do
        expect(calculator).to eq(11_050)
      end
    end

    context 'when 10 rent days' do
      let(:rent_days) { 10 }

      it 'calculates price correctly' do
        expect(calculator).to eq(12_100)
      end
    end

    context 'when 11 rent days' do
      let(:rent_days) { 11 }

      it 'calculates price correctly' do
        expect(calculator).to eq(11_650)
      end
    end
  end
end
