class Message < ApplicationRecord
    belongs_to :sender, class_name: 'User'
    belongs_to :recipient, class_name: 'User'
  
    validates :message, presence: true
  
    scope :admin_messages, -> { where(admin_message: true) }
    scope :user_messages, -> { where(admin_message: false) }
  end