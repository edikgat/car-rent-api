# frozen_string_literal: true

describe Drivy::RentalsRepository do
  subject(:repository) { described_class.instance }

  before do
    Drivy::Car.create(
      id: 1,
      price_per_day: 100,
      price_per_km: 2
    )
  end

  context 'when FlatPriceScaleRental' do
    let(:model) do
      Drivy::FlatPriceScaleRental.new(
        id: model_id,
        car_id: 1,
        start_date: Date.today,
        end_date: Date.today + 1,
        distance: 10
      )
    end
    let(:model_id) { 1 }

    it_behaves_like 'repository'
  end

  context 'when DiscountedPriceScaleRental' do
    let(:model) do
      Drivy::DiscountedPriceScaleRental.new(
        id: model_id,
        car_id: 1,
        start_date: Date.today,
        end_date: Date.today + 1,
        distance: 10
      )
    end
    let(:model_id) { 1 }

    it_behaves_like 'repository'
  end
end
