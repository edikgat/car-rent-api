# frozen_string_literal: true

describe Drivy::RentalComissionPresenter do
  describe '.represent_for' do
    subject(:presenter) { described_class.represent_for(comission) }

    let(:comission) do
      Drivy::RentalComission.new(price: 3000, rent_days: 1)
    end

    it 'represents comission data' do
      expect(presenter).to eq(
        assistance_fee: 100,
        drivy_fee: 350,
        insurance_fee: 450
      )
    end
  end
end
