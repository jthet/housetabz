class AdminMessage < ApplicationRecord
    belongs_to :sender, class_name: 'AdminUser'
    belongs_to :recipient, class_name: 'User'

    def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "message", "read", "recipient_id", "sender_id", "updated_at"]
    end
  end
  