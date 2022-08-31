# frozen_string_literal: true

describe Drivy::FlatScaleRentalPrice do
  describe '.calculate_for' do
    subject(:calculator) do
      described_class.calculate_for(
        price_per_day: 300,
        price_per_km: 10,
        rent_days: 15,
        distance: 1000
      )
    end

    it 'calculates price correctly' do
      expect(calculator).to eq(14_500)
    end
  end
end
