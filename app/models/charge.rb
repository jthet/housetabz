# app/models/charge.rb
class Charge < ApplicationRecord
  belongs_to :user
  belongs_to :bill, optional: true
  has_many :charge_payments
  has_many :payments, through: :charge_payments

  attribute :status, :string, default: 'unpaid'

  before_save :set_name_from_bill
  after_save :update_user_paid_status
  after_update :update_user_paid_status
  after_create :calculate_and_create_house_tab_fee

  validates :estimated, inclusion: { in: [true, false] }

  scope :unpaid, -> { where(status: 'unpaid') }

  def set_name_from_bill
    self.name = bill&.name || 'HouseTab Fee'
  end

  def paid?
    status == 'paid'
  end

  def update_user_paid_status
    user.update(paid_status: user.charges.unpaid.empty?)
    update_bill_status if saved_change_to_status?
  end

  def update_bill_status
    return unless bill.present?

    if bill.charges.all?(&:paid?)
      bill.update(status: 'paid')
    else
      bill.update(status: 'unpaid')
    end
  end

  private

  def calculate_and_create_house_tab_fee
    # Find the user associated with the house that the bill belongs to
    user = self.user

    # Calculate HouseTab fee (3% of total 'unpaid' charges sum)
    total_unpaid_charges = user.charges.unpaid.sum(:amount)
    house_tab_fee_amount = (total_unpaid_charges * 0.03).ceil(2)

    # Find or create the HouseTabFee record for the user
    house_tab_fee = HouseTabFee.find_or_create_by(user: user, status: 'unpaid')

    # Update the amount of the HouseTabFee
    house_tab_fee.update(amount: house_tab_fee_amount)

    # Find the HouseTab Fee charge for the user (if it exists)
    house_tab_fee_charge = Charge.find_by(user: user, name: 'HouseTab Fee', bill: nil)

    if house_tab_fee_charge
      # Update the HouseTab Fee charge amount and status
      house_tab_fee_charge.update(amount: house_tab_fee_amount, status: 'unpaid')
    else
      # Create a new Charge record for the HouseTab Fee if it doesn't exist
      Charge.create(
        user: user,
        amount: house_tab_fee_amount,
        status: 'unpaid',
        name: 'HouseTab Fee',
        bill: nil, # Since this is not related to a specific bill, set bill to nil
        estimated: false
      )
    end
  end
end
