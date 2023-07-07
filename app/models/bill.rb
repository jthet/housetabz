class Bill < ApplicationRecord
  belongs_to :house
  has_many :charges
  attribute :status, :string

  after_create :create_charges
  before_save :update_bill_status

  def create_charges
    total_users = house.users.count
    charge_amount = amount.to_f / total_users.to_f

    house.users.each do |user|
      charge = user.charges.create(amount: charge_amount, bill: self)
      self.charges << charge
    end
  end

  def update_bill_status
    if status_changed? && status_was == 'unpaid' && status == 'paid'
      PaidBill.create_from_bill(self) # Create a PaidBill record for the paid bill
    end
  end
end