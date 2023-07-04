class Charge < ApplicationRecord
  belongs_to :user
  belongs_to :bill
  has_many :charge_payments
  has_many :payments, through: :charge_payments

  attribute :status, :string, default: 'unpaid'

  before_save :set_name_from_bill
  after_save :update_user_paid_status

  def set_name_from_bill
    self.name = bill.name
  end

  def paid?
    status == 'paid'
  end

  def update_user_paid_status
    user.update(paid_status: user.charges.reload.where(status: 'unpaid').empty?)
  end
  
end
