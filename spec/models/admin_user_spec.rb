require 'rails_helper'

RSpec.describe AdminUser, type: :model do
  # Example: Testing the presence validation for email
  it "is valid with valid attributes" do
    admin_user = FactoryBot.build(:admin_user)
    expect(admin_user).to be_valid
  end

  it "is not valid without an email" do
    admin_user = FactoryBot.build(:admin_user, email: nil)
    expect(admin_user).not_to be_valid
  end

  it "is not valid without a password" do
    admin_user = FactoryBot.build(:admin_user, password: nil)
    expect(admin_user).not_to be_valid
  end

  it "is not valid with a duplicate email" do
    FactoryBot.create(:admin_user, email: "duplicate@example.com")
    admin_user = FactoryBot.build(:admin_user, email: "duplicate@example.com")
    expect(admin_user).not_to be_valid
  end

  it "is valid with a unique email" do
    FactoryBot.create(:admin_user, email: "unique@example.com")
    admin_user = FactoryBot.build(:admin_user, email: "new@example.com")
    expect(admin_user).to be_valid
  end

  it "is not valid with a short password" do
    admin_user = FactoryBot.build(:admin_user, password: "123")
    expect(admin_user).not_to be_valid
  end

  it "is not valid with a long password" do
    admin_user = FactoryBot.build(:admin_user, password: "a" * 129)
    expect(admin_user).not_to be_valid
  end

  it "is valid with a password of minimum length" do
    admin_user = FactoryBot.build(:admin_user, password: "a" * 6)
    expect(admin_user).to be_valid
  end

  # Add more tests as needed
end
