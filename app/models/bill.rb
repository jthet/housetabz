class Bill < ApplicationRecord
  belongs_to :house
  has_many :charges

  after_create :create_charges


  def create_charges
    total_users = house.users.count
    charge_amount = amount.to_f / total_users.to_f
  
    house.users.each do |user|
      user.charges.create(amount: charge_amount, bill: self, paid: false)
    end
  end
  
 

end
