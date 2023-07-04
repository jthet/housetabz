class Bill < ApplicationRecord
  belongs_to :house
  has_many :charges
  attribute :status, :string

  after_create :create_charges

  def create_charges
    total_users = house.users.count
    charge_amount = amount.to_f / total_users.to_f
  
    house.users.each do |user|
      charge = user.charges.create(amount: charge_amount, bill: self)
      self.charges << charge
    end

    update_status
  end

  def update_status
    if house.users.all?(&:paid_status)
      puts "All users have paid"
      self.status = 'paid'
    else
      puts "Some users have not paid"
      self.status = 'unpaid'
    end

    save
  end
end
