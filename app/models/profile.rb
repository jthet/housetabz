# frozen_string_literal: true

class Profile < ApplicationRecord
  has_one_attached :profile_picture

  belongs_to :user

  validates :first_name, :last_name, presence: true
end
