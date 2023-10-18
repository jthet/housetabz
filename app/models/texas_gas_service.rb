# app/models/texas_gas_service.rb

class TexasGasService < ApplicationRecord
  # Assuming you have attributes like :account_number and other_attributes
  validates :account_number, presence: true
  # Add other validation rules as needed
end
