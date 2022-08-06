# frozen_string_literal: true

describe Drivy::Car do
  let(:model_data) do
    {
      id: id,
      price_per_day: price_per_day,
      price_per_km: price_per_km
    }
  end
  let(:id) { 1 }
  let(:price_per_day) { 1000 }
  let(:price_per_km) { 20 }

  describe '.create' do
    subject(:create_car) { described_class.create(model_data) }

    let(:added_car) { Drivy::CarsRepository.all.last }

    it 'adds new model to repository' do
      expect { create_car }.to change { Drivy::CarsRepository.all.size }.by(1)
    end

    it 'adds a model with correct params to repository' do
      create_car

      expect(added_car.id).to eq(id)
      expect(added_car.price_per_day).to eq(price_per_day)
      expect(added_car.price_per_km).to eq(price_per_km)
    end
  end

  include_examples 'models validations'

  describe '#valid?' do
    subject(:car) { described_class.new(model_data) }

    it_behaves_like 'validates presence', :id
    it_behaves_like 'validates presence', :price_per_day
    it_behaves_like 'validates presence', :price_per_km

    it_behaves_like 'validates positive integer', :id
    it_behaves_like 'validates positive integer', :price_per_day
    it_behaves_like 'validates positive integer', :price_per_km

    context 'when model with given id already exists' do
      before do
        described_class.create(model_data)
      end

      it_behaves_like 'raises an validation error',
                      Regexp.new(Drivy::BaseModel::UNIQUE_ERROR_MESSAGE)
    end

    context 'when price per date is less than 100' do
      let(:price_per_day) { 50 }

      it_behaves_like 'raises an validation error',
                      Regexp.new(Drivy::Car::PRICE_PER_DATE_VALUE_ERROR_MESSAGE)
    end

    context 'when all parameters valid' do
      it_behaves_like 'be valid'
    end
  end
end
