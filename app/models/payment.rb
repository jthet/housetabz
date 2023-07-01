class Payment < ApplicationRecord
    belongs_to :user
    has_many :charge_payments
    has_many :charges, through: :charge_payments
end
