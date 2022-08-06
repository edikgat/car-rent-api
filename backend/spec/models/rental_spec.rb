# frozen_string_literal: true

describe Drivy::Rental do
  subject(:rental) { described_class.new(model_data) }

  let(:model_data) do
    {
      id: id,
      car_id: car_id,
      start_date: start_date,
      end_date: end_date,
      distance: distance
    }
  end
  let(:id) { 1 }
  let(:car_id) { 1 }
  let(:distance) { 2 }
  let(:start_date) { Date.today }
  let(:end_date) { Date.today + 10 }

  before do
    Drivy::Car.create(
      id: 1,
      price_per_day: 100,
      price_per_km: 2
    )
  end

  describe '.create' do
    subject(:create_rental) { described_class.create(model_data) }

    let(:added_rental) { Drivy::RentalsRepository.all.last }

    it 'adds new model to repository' do
      expect { create_rental }.to change { Drivy::RentalsRepository.all.size }.by(1)
    end

    it 'adds a model with correct params to repository' do
      create_rental

      expect(added_rental.id).to eq(id)
      expect(added_rental.car_id).to eq(car_id)
      expect(added_rental.start_date).to eq(start_date)
      expect(added_rental.end_date).to eq(end_date)
      expect(added_rental.distance).to eq(distance)
    end
  end

  include_examples 'models validations'

  describe '#valid?' do
    it_behaves_like 'validates presence', :id
    it_behaves_like 'validates presence', :car_id
    it_behaves_like 'validates presence', :start_date
    it_behaves_like 'validates presence', :end_date
    it_behaves_like 'validates presence', :distance

    it_behaves_like 'validates positive integer', :id
    it_behaves_like 'validates positive integer', :car_id
    it_behaves_like 'validates positive integer', :distance

    it_behaves_like 'validates date', :start_date
    it_behaves_like 'validates date', :end_date

    context 'when model with given id already exists' do
      before do
        described_class.create(model_data)
      end

      it_behaves_like 'raises an validation error',
                      Regexp.new(Drivy::BaseModel::UNIQUE_ERROR_MESSAGE)
    end

    context 'when start date is less than end date' do
      let(:start_date) { Date.today }
      let(:end_date) { Date.today - 10 }

      it_behaves_like 'raises an validation error',
                      Regexp.new(Drivy::BaseModel::POSITIVE_INTEGER_VALIDATION_ERROR_MESSAGE)
    end

    context 'when car with given id is not exist' do
      let(:car_id) { 100_500 }

      it_behaves_like 'raises an validation error',
                      Regexp.new(Drivy::BaseModel::PRESENCE_VALIDATION_ERROR_MESSAGE)
    end

    context 'when for given dates already exists other rental' do
      before do
        described_class.create(model_data.merge(id: 2, start_date: Date.today - 1))
      end

      it_behaves_like 'raises an validation error',
                      Regexp.new(Drivy::Rental::OVERBOOKING_ERROR_MESSAGE)
    end

    context 'when all parameters valid' do
      it_behaves_like 'be valid'
    end
  end

  describe '#price' do
    it 'returns expected price' do
      expect(rental.price).to eq(1104)
    end
  end
end
