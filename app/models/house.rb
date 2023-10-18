class House < ApplicationRecord

    has_secure_password
    has_many :users
    has_many :bills
    has_many :paid_bills

    def self.ransackable_attributes(auth_object = nil)
        ["address", "created_at", "id", "joinable", "name", "password_digest", "updated_at", "bills_id"]
      end

      def self.ransackable_associations(auth_object = nil)
        ["bills", "paid_bills", "users"]
      end

    def total_charge
        bills.sum(:amount)
    end
    
end
