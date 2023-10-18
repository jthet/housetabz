# app/models/city_of_austin_utilities_service.rb

class CityOfAustinUtilitiesService < ApplicationRecord
  # Assuming you have attributes like :account_number and other_attributes
  validates :account_number, presence: true
  # Add other validation rules as needed
end
