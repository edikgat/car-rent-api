# frozen_string_literal: true

describe Drivy::RentalOptionsRepository do
  subject(:repository) { described_class.instance }

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

  let(:model) do
    Drivy::RentalOption.new(
      id: model_id,
      rental_id: 1,
      type: 'gps'
    )
  end
  let(:model_id) { 1 }

  it_behaves_like 'repository'
end
