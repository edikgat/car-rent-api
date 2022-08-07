# frozen_string_literal: true

describe Drivy::RentalPriceDetails do
  subject(:price_details) do
    described_class.new(price: price, rent_days: rent_days)
  end

  context 'when price is 3000 and 1 rent day' do
    let(:rent_days) { 1 }
    let(:price) { 3000 }

    it 'calculates insurance_fee' do
      expect(price_details.insurance_fee).to eq(450)
    end

    it 'calculates total_fee' do
      expect(price_details.total_fee).to eq(900)
    end

    it 'calculates assistance_fee' do
      expect(price_details.assistance_fee).to eq(100)
    end

    it 'calculates drivy_fee' do
      expect(price_details.drivy_fee).to eq(350)
    end

    it 'returns owner_payment' do
      expect(price_details.owner_payment).to eq(2100)
    end

    it 'returns price' do
      expect(price_details.price).to eq(3000)
    end
  end

  context 'when price is 6800 and 2 rent day' do
    let(:rent_days) { 2 }
    let(:price) { 6800 }

    it 'calculates insurance_fee' do
      expect(price_details.insurance_fee).to eq(1020)
    end

    it 'calculates total_fee' do
      expect(price_details.total_fee).to eq(2040)
    end

    it 'calculates assistance_fee' do
      expect(price_details.assistance_fee).to eq(200)
    end

    it 'calculates drivy_fee' do
      expect(price_details.drivy_fee).to eq(820)
    end

    it 'returns owner_payment' do
      expect(price_details.owner_payment).to eq(4760)
    end

    it 'returns price' do
      expect(price_details.price).to eq(6800)
    end
  end

  context 'when price is 27800 and 12 rent day' do
    let(:rent_days) { 12 }
    let(:price) { 27_800 }

    it 'calculates insurance_fee' do
      expect(price_details.insurance_fee).to eq(4170)
    end

    it 'calculates total_fee' do
      expect(price_details.total_fee).to eq(8340)
    end

    it 'calculates assistance_fee' do
      expect(price_details.assistance_fee).to eq(1200)
    end

    it 'calculates drivy_fee' do
      expect(price_details.drivy_fee).to eq(2970)
    end

    it 'returns owner_payment' do
      expect(price_details.owner_payment).to eq(19_460)
    end

    it 'returns price' do
      expect(price_details.price).to eq(27_800)
    end
  end
end
