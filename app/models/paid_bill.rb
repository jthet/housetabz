class PaidBill < ApplicationRecord
    belongs_to :bill
  
    def self.create_from_bill(bill)
      PaidBill.create(bill: bill, house_id: bill.house_id)
    end
  end
  