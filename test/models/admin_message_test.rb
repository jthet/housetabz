# test/models/admin_message_test.rb

require 'test_helper'

class AdminMessageTest < ActiveSupport::TestCase
  # Setup method to create necessary objects for testing
  def setup
    @admin_user = AdminUser.create(email: "testAdmin@example.com", password: "password")  # Add necessary attributes for AdminUser
    @user = User.create(email: "testUser@example.com", password: "password", username: "testUser")  # Add necessary attributes for User
    @admin_message = AdminMessage.new(sender: @admin_user, recipient: @user, message: "Hello World!")
  end

  test "should be valid" do
    assert @admin_message.valid?
  end

  test "should belong to sender of class AdminUser" do
    assert @admin_message.sender.instance_of?(AdminUser)
  end

  test "should belong to recipient of class User" do
    assert @admin_message.recipient.instance_of?(User)
  end

  test "ransackable_attributes should return expected attributes" do
    expected_attributes = %w[created_at id message read recipient_id sender_id updated_at]
    assert_equal expected_attributes, AdminMessage.ransackable_attributes
  end
end
