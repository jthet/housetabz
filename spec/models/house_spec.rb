# spec/models/house_spec.rb
require 'rails_helper'

RSpec.describe House, type: :model do
  it 'is valid with valid attributes' do
    house = FactoryBot.create(:house)
    expect(house).to be_valid
  end

  it 'is not valid without a name' do
    house = FactoryBot.build(:house, name: nil)
    expect(house).not_to be_valid
  end

  it 'is not valid without an address' do
    house = FactoryBot.build(:house, address: nil)
    expect(house).not_to be_valid
  end

  it 'is not valid without a password digest' do
    house = FactoryBot.build(:house, password_digest: nil)
    expect(house).not_to be_valid
  end
end