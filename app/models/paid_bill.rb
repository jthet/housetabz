# frozen_string_literal: true

class PaidBill < ApplicationRecord
  belongs_to :bill

  def self.ransackable_attributes(_auth_object = nil)
    %w[bill_id created_at house_id id updated_at user_id]
  end

  def self.create_from_bill(bill)
    PaidBill.create(bill:, house_id: bill.house_id)
  end
end
