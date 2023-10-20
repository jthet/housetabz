class Bill < ApplicationRecord
  belongs_to :house
  belongs_to :tab, optional: true
  after_save :update_tab_paid_status
  has_many :charges, dependent: :destroy
  has_one_attached :bill_image
  attribute :status, :string
  attribute :estimated, :boolean, default: false
  after_create :create_charges
  before_save :update_bill_status
  validates :estimated, inclusion: { in: [true, false] }
  validates :amount, numericality: true

  after_create :create_or_find_tab_for_month

  def self.ransackable_attributes(_auth_object = nil)
    %w[amount bill_image house_id name estimated decimal status tab_id]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[bill_image_attachment bill_image_blob charges house]
  end

  def create_charges
    total_users = house.users.count
    charge_amount = BigDecimal(amount.to_s) / BigDecimal(total_users.to_s)
    rounded_charge_amount = charge_amount.ceil(2)

    house.users.each do |user|
      charge = user.charges.create(amount: rounded_charge_amount, bill: self, estimated:)
      charges << charge
    end
  end

  def update_bill_status
    return unless status_changed? && status_was == 'unpaid' && status == 'paid'

    PaidBill.create_from_bill(self) # Create a PaidBill record for the paid bill
  end

  private

  def create_or_find_tab_for_month
    month = created_at.month
    year = created_at.year

    tab = Tab.find_or_create_by(month:, year:)
    update(tab:)
  end

  def update_tab_paid_status
    tab.update_paid_status if tab.present?
  end
end
