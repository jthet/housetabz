class House < ApplicationRecord
    has_secure_password
    has_many :users
    has_many :bills

    def total_charge
        bills.sum(:amount)
    end
    
end
