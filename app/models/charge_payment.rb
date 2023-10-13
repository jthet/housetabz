class ChargePayment < ApplicationRecord
    belongs_to :payment
    belongs_to :charge
    def self.ransackable_attributes(auth_object = nil)
    ["charge_id", "created_at", "id", "payment_id", "updated_at"]
    end

  end