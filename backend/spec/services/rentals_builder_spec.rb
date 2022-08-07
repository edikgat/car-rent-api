# frozen_string_literal: true

describe Drivy::RentalsBuilder do
  describe '.build_for' do
    subject(:builder) { described_class.build_for([rental_data], rental_class: Drivy::FlatPriceScaleRental) }

    let(:rental_data) do
      { 'id' => id,
        'car_id' => car_id,
        'distance' => distance,
        'start_date' => start_date,
        'end_date' => end_date }
    end
    let(:id) { 1 }
    let(:start_date) { '2017-12-8' }
    let(:end_date) { '2017-12-10' }
    let(:car_id) { 1 }
    let(:distance) { 10 }

    before do
      Drivy::Car.create(
        id: 1,
        price_per_day: 100,
        price_per_km: 2
      )
    end

    context 'when invalid data' do
      context 'when invalid id' do
        let(:id) { nil }

        it 'raises a validation error' do
          expect { builder }.to raise_error(Drivy::BaseModel::ValidationError)
        end
      end

      context 'when invalid dates' do
        shared_examples 'raises a date parsing error' do
          it 'raises a date parsing error' do
            expect { builder }.to raise_error(Date::Error)
          end
        end

        context 'when invalid start_date' do
          let(:start_date) { 'invalid' }

          it_behaves_like 'raises a date parsing error'
        end

        context 'when invalid end_date' do
          let(:end_date) { 'invalid' }

          it_behaves_like 'raises a date parsing error'
        end
      end
    end

    context 'when valid data' do
      let(:added_rental) { Drivy::RentalsRepository.all.last }

      it 'adds new rental to repository' do
        expect { builder }.to change { Drivy::RentalsRepository.all.size }.by(1)
      end

      it 'adds a model with correct params to repository' do
        builder

        expect(added_rental.id).to eq(id)
        expect(added_rental.car_id).to eq(car_id)
        expect(added_rental.start_date).to eq(Date.strptime(start_date, '%Y-%m-%d'))
        expect(added_rental.end_date).to eq(Date.strptime(end_date, '%Y-%m-%d'))
        expect(added_rental.distance).to eq(distance)
      end
    end
  end
end
