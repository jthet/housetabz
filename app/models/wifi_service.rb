# app/models/wifi_service.rb

class WifiService < ApplicationRecord
  # Assuming you have attributes like :network_name and other_attributes
  validates :network_name, presence: true
  # Add other validation rules as needed
end
