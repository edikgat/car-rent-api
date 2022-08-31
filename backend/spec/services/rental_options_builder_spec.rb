# frozen_string_literal: true

describe Drivy::RentalOptionsBuilder do
  describe '.build_for' do
    subject(:builder) { described_class.build_for([rental_option_data]) }

    before do
      Drivy::Car.create(
        id: 1,
        price_per_day: 100,
        price_per_km: 2
      )
      Drivy::DiscountedPriceScaleRental.create(
        id: 1,
        car_id: 1,
        start_date: Date.today,
        end_date: Date.today + 1,
        distance: 10
      )
    end

    context 'when invalid data' do
      let(:rental_option_data) { { 'id' => 1 } }

      it 'raises a validation error' do
        expect { builder }.to raise_error(Drivy::BaseModel::ValidationError)
      end
    end

    context 'when valid data' do
      let(:rental_option_data) { { 'id' => 1, 'rental_id' => 1, 'type' => 'gps' } }
      let(:added_option) { Drivy::RentalOptionsRepository.all.last }

      it 'adds new option to repository' do
        expect { builder }.to change { Drivy::RentalOptionsRepository.all.size }.by(1)
      end

      it 'adds a option with correct params to repository' do
        builder

        expect(added_option.id).to eq(1)
        expect(added_option.rental_id).to eq(1)
        expect(added_option.type).to eq('gps')
      end
    end
  end
end
