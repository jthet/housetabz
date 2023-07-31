class Charge < ApplicationRecord
  belongs_to :user
  belongs_to :bill, optional: true
  has_many :charge_payments
  has_many :payments, through: :charge_payments

  attribute :status, :string, default: 'unpaid'

  before_save :set_name_from_bill
  after_save :update_user_paid_status
  after_create :calculate_and_create_house_tab_fee
  after_update :update_user_paid_status

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
    house_tab_fee_amount = total_unpaid_charges * 0.03

    # Find or create the HouseTabFee record for the user
    house_tab_fee = HouseTabFee.find_or_create_by(user: user, status: 'unpaid')

    # Update the amount of the HouseTabFee
    house_tab_fee.update(amount: house_tab_fee_amount)

    # Check if a Charge record already exists for the HouseTabFee
    house_tab_fee_charge = Charge.find_by(name: 'HouseTab Fee', bill_id: nil, user_id: user.id)

    if house_tab_fee_charge
      # If a Charge record exists, update the amount
      house_tab_fee_charge.update(amount: house_tab_fee_amount, status: 'unpaid')
    else
      # If no Charge record exists, create a new Charge record for the HouseTabFee
      Charge.create(
        user: user,
        amount: house_tab_fee_amount,
        status: 'unpaid',
        name: 'HouseTab Fee',
        bill: nil # Since this is not related to a specific bill, set bill to nil
      )
    end
  end
end # app/controllers/charges_controller.rb