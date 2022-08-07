# frozen_string_literal: true

describe Drivy::CarsBuilder do
  describe '.build_for' do
    subject(:builder) { described_class.build_for([car_data]) }

    context 'when invalid data' do
      let(:car_data) { { 'id' => 1 } }

      it 'raises a validation error' do
        expect { builder }.to raise_error(Drivy::BaseModel::ValidationError)
      end
    end

    context 'when valid data' do
      let(:car_data) { { 'id' => 1, 'price_per_day' => 2000, 'price_per_km' => 10 } }
      let(:added_car) { Drivy::CarsRepository.all.last }

      it 'adds new car to repository' do
        expect { builder }.to change { Drivy::CarsRepository.all.size }.by(1)
      end

      it 'adds a car with correct params to repository' do
        builder

        expect(added_car.id).to eq(1)
        expect(added_car.price_per_day).to eq(2000)
        expect(added_car.price_per_km).to eq(10)
      end
    end
  end
end
