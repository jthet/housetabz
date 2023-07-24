class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :profile, dependent: :destroy
  has_one :member
  has_one :balance
  has_many :charges, dependent: :destroy
  has_many :payments
  has_many :messages, foreign_key: :recipient_id
  has_many :admin_messages, foreign_key: :recipient_id, class_name: 'AdminMessage'


  has_many :house_tab_fees
  belongs_to :house, optional: true
  
  validates :username, presence: true, uniqueness: true
  
  def has_unpaid_charges?
    charges.unpaid.any?
  end

  def calculate_balance
    charges_sum = charges.sum(:amount)
    payments_sum = payments.sum(:amount)
    charges_sum - payments_sum
  end
  
  def update_paid_status
    puts "Updating paid status for User ID: #{id}"
    
    charges_status = charges.reload.pluck(:status)
    puts "Charges Status: #{charges_status}"
    
    unpaid_charges = charges.reload.where.not(status: 'paid')
    puts "Unpaid Charges: #{unpaid_charges.inspect}"
  
    self.update(paid_status: unpaid_charges.empty?)
    puts "Paid Status Updated: #{paid_status}"
  end
  
  def soft_delete
    charges_sum = user.charges.sum(:amount)
    payments_sum = user.payments.sum(:amount)
    DeletedUser.create(
      username: username,
      first_name: profile&.first_name,
      last_name: profile&.last_name,
      charges_sum: charges.sum(:amount),
      payments_sum: payments.sum(:amount),
      balance_sum: balance&.amount.to_f
    )

    charges.destroy_all # Delete associated charges
    destroy
  end
end