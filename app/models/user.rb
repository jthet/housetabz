class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :profile
  has_one :member
  has_one :balance
  has_many :charges
  has_many :payments
  belongs_to :house, optional: true
  
  validates :username, presence: true, uniqueness: true
  
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
  
  

end
