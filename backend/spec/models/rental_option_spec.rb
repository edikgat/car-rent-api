# frozen_string_literal: true

describe Drivy::RentalOption do
  let(:model_data) do
    {
      id: id,
      rental_id: rental_id,
      type: type
    }
  end
  let(:id) { 1 }
  let(:rental_id) { 1 }
  let(:type) { 'gps' }

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

  describe '.create' do
    subject(:create_option) { described_class.create(model_data) }

    let(:added_car) { Drivy::RentalOptionsRepository.all.last }

    it 'adds new model to repository' do
      expect { create_option }.to change { Drivy::RentalOptionsRepository.all.size }.by(1)
    end

    it 'adds a model with correct params to repository' do
      create_option

      expect(added_car.id).to eq(id)
      expect(added_car.rental_id).to eq(rental_id)
      expect(added_car.type).to eq(type)
    end
  end

  include_examples 'models validations'

  describe '#valid?' do
    subject(:car) { described_class.new(model_data) }

    it_behaves_like 'validates presence', :id
    it_behaves_like 'validates presence', :rental_id
    it_behaves_like 'validates presence', :type

    it_behaves_like 'validates positive integer', :id
    it_behaves_like 'validates positive integer', :rental_id

    context 'when rental with given id does not exist' do
      let(:rental_id) { 100_500 }

      it_behaves_like 'raises an validation error',
                      Regexp.new(Drivy::BaseModel::PRESENCE_VALIDATION_ERROR_MESSAGE)
    end

    context 'when type is not included in the list' do
      let(:type) { 'invalid' }

      it_behaves_like 'raises an validation error',
                      Regexp.new(Drivy::BaseModel::INCLUSION_ERROR_MESSAGE)
    end

    context 'when model with given id already exists' do
      before do
        described_class.create(model_data)
      end

      it_behaves_like 'raises an validation error',
                      Regexp.new(Drivy::BaseModel::UNIQUE_ERROR_MESSAGE)
    end

    context 'when additional insurance option already exists for reservation' do
      let(:type) { 'additional_insurance' }

      before do
        described_class.create(id: 2, rental_id: 1, type: 'additional_insurance')
      end

      it_behaves_like 'raises an validation error',
                      Regexp.new(Drivy::RentalOption::SINGLE_ADDITIONAL_INSURANCE_ERROR_MESSAGE)
    end

    context 'when all parameters valid' do
      it_behaves_like 'be valid'
    end
  end
end
