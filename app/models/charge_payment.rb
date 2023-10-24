# frozen_string_literal: true

class ChargePayment < ApplicationRecord
  belongs_to :payment
  belongs_to :charge
  def self.ransackable_attributes(_auth_object = nil)
    %w[charge_id created_at id payment_id updated_at]
  end
end
