class ChargesController < ApplicationController
    def calculate_charges
        @bills = Bill.all
      
        current_user.house.users.each do |user|
          user_charge = @bills.sum { |bill| bill.calculate_charge / current_user.house.users.count }
          user.charges.create(amount: user_charge, paid: false)
        end
      end
end
