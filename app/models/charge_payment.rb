class ChargePayment < ApplicationRecord
    belongs_to :payment
    belongs_to :charge
  end