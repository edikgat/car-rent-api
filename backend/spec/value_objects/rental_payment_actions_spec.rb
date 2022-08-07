# frozen_string_literal: true

describe Drivy::RentalPaymentActions do
  subject(:payment_actions) { described_class.new(price_details) }

  let(:price_details) do
    Drivy::RentalPriceDetails.new(
      price_per_day: 2000,
      price_per_km: 10,
      distance: 280,
      rent_days: 2,
      option_types: ['additional_insurance'],
      price_calculator_class: Drivy::FlatScaleRentalPrice
    )
  end

  it 'returns driver action' do
    expect(payment_actions.driver).to eq(
      amount: 8800,
      type: :debit,
      who: :driver
    )
  end

  it 'returns owner action' do
    expect(payment_actions.owner).to eq(
      amount: 4760,
      type: :credit,
      who: :owner
    )
  end

  it 'returns insurance action' do
    expect(payment_actions.insurance).to eq(
      amount: 1020,
      type: :credit,
      who: :insurance
    )
  end

  it 'returns assistance action' do
    expect(payment_actions.assistance).to eq(
      amount: 200,
      type: :credit,
      who: :assistance
    )
  end

  it 'returns drivy action' do
    expect(payment_actions.drivy).to eq(
      amount: 2820,
      type: :credit,
      who: :drivy
    )
  end
end
