# spec/models/user_spec.rb
require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with valid attributes' do
    user = FactoryBot.create(:user, password: 'password123') # Provide a valid password
    expect(user).to be_valid
  end

  it 'is not valid without a username' do
    user = FactoryBot.build(:user, username: nil, password: 'password123') # Provide a valid password
    expect(user).not_to be_valid
  end
end
