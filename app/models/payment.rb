# frozen_string_literal: true

class Payment < ApplicationRecord
  belongs_to :user
  has_many :charge_payments
  has_many :charges, through: :charge_payments

  after_create :update_user_paid_status

  private

  def update_user_paid_status
    user.update_paid_status
  end
end
