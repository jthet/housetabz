# spec/models/message_spec.rb

require 'rails_helper'

RSpec.describe Message, type: :model do
  describe "validations" do
    it "is valid with valid attributes" do
      message = FactoryBot.build(:message)
      expect(message).to be_valid
    end

    it "is not valid without a message" do
      message = FactoryBot.build(:message, message: nil)
      expect(message).not_to be_valid
    end
  end

  describe "associations" do
    it { should belong_to(:sender).class_name('User') }
    it { should belong_to(:recipient).class_name('User') }
  end

  describe "scopes" do
    it "returns admin messages with admin_messages scope" do
      admin_message = FactoryBot.create(:message, admin_message: true)
      user_message = FactoryBot.create(:message, admin_message: false)

      admin_messages = Message.admin_messages

      expect(admin_messages).to include(admin_message)
      expect(admin_messages).not_to include(user_message)
    end

    it "returns user messages with user_messages scope" do
      admin_message = FactoryBot.create(:message, admin_message: true)
      user_message = FactoryBot.create(:message, admin_message: false)

      user_messages = Message.user_messages

      expect(user_messages).to include(user_message)
      expect(user_messages).not_to include(admin_message)
    end
  end
end
