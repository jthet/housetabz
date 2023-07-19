class AdminMessage < ApplicationRecord
    belongs_to :sender, class_name: 'AdminUser'
    belongs_to :recipient, class_name: 'User'
  end
  