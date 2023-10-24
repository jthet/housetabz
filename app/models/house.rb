# frozen_string_literal: true

class House < ApplicationRecord
  has_secure_password
  has_many :users
  has_many :bills
  has_many :tabs
  has_many :paid_bills

  def self.ransackable_attributes(_auth_object = nil)
    %w[address created_at id joinable name password_digest updated_at bills_id tabs_id]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[bills paid_bills users]
  end

  def total_charge
    bills.sum(:amount)
  end
end
