# spec/models/admin_message_spec.rb

require 'rails_helper'

RSpec.describe AdminMessage, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      admin_message = FactoryBot.create(:admin_message)
      expect(admin_message).to be_valid
    end

    it 'is not valid without a sender_id' do
      admin_message = FactoryBot.build(:admin_message, sender_id: nil)
      expect(admin_message).not_to be_valid
    end

    it 'is not valid without a recipient_id' do
      admin_message = FactoryBot.build(:admin_message, recipient_id: nil)
      expect(admin_message).not_to be_valid
    end

    it 'is not valid without a message' do
      admin_message = FactoryBot.build(:admin_message, message: nil)
      expect(admin_message).not_to be_valid
    end
  end

  describe 'associations' do
    it 'belongs to a sender (AdminUser)' do
      sender_association = described_class.reflect_on_association(:sender)
      expect(sender_association.macro).to eq(:belongs_to)
      expect(sender_association.class_name).to eq('AdminUser')
    end

    it 'belongs to a recipient (User)' do
      recipient_association = described_class.reflect_on_association(:recipient)
      expect(recipient_association.macro).to eq(:belongs_to)
      expect(recipient_association.class_name).to eq('User')
    end
  end

  describe 'ransackable_attributes' do
    it 'returns the expected attributes' do
      expected_attributes = %w[created_at id message read recipient_id sender_id updated_at]
      expect(AdminMessage.ransackable_attributes).to eq(expected_attributes)
    end
  end
end
