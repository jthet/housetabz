class Bill < ApplicationRecord
  belongs_to :house
  has_many :charges
  has_one_attached :bill_image
  attribute :status, :string
  attribute :estimated, :boolean, default: false
  after_create :create_charges
  before_save :update_bill_status

  def create_charges
    total_users = house.users.count
    charge_amount = BigDecimal(amount.to_s) / BigDecimal(total_users.to_s)
    rounded_charge_amount = charge_amount.ceil(2)

    house.users.each do |user|
      charge = user.charges.create(amount: rounded_charge_amount, bill: self)
      self.charges << charge
    end
  end

  def update_bill_status
    if status_changed? && status_was == 'unpaid' && status == 'paid'
      PaidBill.create_from_bill(self) # Create a PaidBill record for the paid bill
    end
  end
end