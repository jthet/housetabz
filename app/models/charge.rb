class Charge < ApplicationRecord
  belongs_to :user
  belongs_to :bill
  has_many :charge_payments
  has_many :payments, through: :charge_payments

  attribute :status, :string, default: 'unpaid'
end
