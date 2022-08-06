# frozen_string_literal: true

describe Drivy::CarsRepository do
  subject(:repository) { described_class.instance }

  let(:model) do
    Drivy::Car.new(
      id: model_id,
      price_per_day: 100,
      price_per_km: 2
    )
  end

  let(:model_id) { 1 }

  it_behaves_like 'repository'
end
