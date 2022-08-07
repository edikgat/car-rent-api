# frozen_string_literal: true

describe Drivy::RentalPaymentActions do
  subject(:payment_actions) { described_class.new(price_details) }

  let(:price_details) do
    Drivy::RentalPriceDetails.new(price: 27_800, rent_days: 12)
  end

  it 'returns driver action' do
    expect(payment_actions.driver).to eq(
      amount: 27_800,
      type: :debit,
      who: :driver
    )
  end

  it 'returns owner action' do
    expect(payment_actions.owner).to eq(
      amount: 19_460,
      type: :credit,
      who: :owner
    )
  end

  it 'returns insurance action' do
    expect(payment_actions.insurance).to eq(
      amount: 4170,
      type: :credit,
      who: :insurance
    )
  end

  it 'returns assistance action' do
    expect(payment_actions.assistance).to eq(
      amount: 1200,
      type: :credit,
      who: :assistance
    )
  end

  it 'returns drivy action' do
    expect(payment_actions.drivy).to eq(
      amount: 2970,
      type: :credit,
      who: :drivy
    )
  end
end
