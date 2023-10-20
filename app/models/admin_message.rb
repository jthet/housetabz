class AdminMessage < ApplicationRecord
  belongs_to :sender, class_name: 'AdminUser'
  belongs_to :recipient, class_name: 'User'

  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at id message read recipient_id sender_id updated_at]
  end
end
