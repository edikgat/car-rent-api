# frozen_string_literal: true

describe Drivy::RentalComission do
  subject(:comission) do
    described_class.new(price: price, rent_days: rent_days)
  end

  context 'when price is 3000 and 1 rent day' do
    let(:rent_days) { 1 }
    let(:price) { 3000 }

    it 'calculates insurance_fee' do
      expect(comission.insurance_fee).to eq(450)
    end

    it 'calculates total_fee' do
      expect(comission.total_fee).to eq(900)
    end

    it 'calculates assistance_fee' do
      expect(comission.assistance_fee).to eq(100)
    end

    it 'calculates drivy_fee' do
      expect(comission.drivy_fee).to eq(350)
    end
  end

  context 'when price is 6800 and 2 rent day' do
    let(:rent_days) { 2 }
    let(:price) { 6800 }

    it 'calculates insurance_fee' do
      expect(comission.insurance_fee).to eq(1020)
    end

    it 'calculates total_fee' do
      expect(comission.total_fee).to eq(2040)
    end

    it 'calculates assistance_fee' do
      expect(comission.assistance_fee).to eq(200)
    end

    it 'calculates drivy_fee' do
      expect(comission.drivy_fee).to eq(820)
    end
  end

  context 'when price is 27800 and 12 rent day' do
    let(:rent_days) { 12 }
    let(:price) { 27_800 }

    it 'calculates insurance_fee' do
      expect(comission.insurance_fee).to eq(4170)
    end

    it 'calculates total_fee' do
      expect(comission.total_fee).to eq(8340)
    end

    it 'calculates assistance_fee' do
      expect(comission.assistance_fee).to eq(1200)
    end

    it 'calculates drivy_fee' do
      expect(comission.drivy_fee).to eq(2970)
    end
  end
end
