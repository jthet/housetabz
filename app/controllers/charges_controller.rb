# app/controllers/charges_controller.rb
class ChargesController < ApplicationController
  def calculate_charges
    @bills = Bill.all

    current_user.house.users.each do |user|
      user_bills = @bills.select { |bill| bill.user_id == user.id }

      total_charge_in_cents = user_bills.sum { |bill| (bill.calculate_charge * 100 / current_user.house.users.count).round }
      user_charge = total_charge_in_cents / 100.0

      # Round up user_charge to the nearest cent using BigDecimal
      user_charge = BigDecimal(user_charge.to_s).ceil(2).to_f

      user.charges.create(amount: user_charge, status: 'unpaid')

      # Calculate and create HouseTab fee for each user
      calculate_and_create_house_tab_fee(user)
    end
  end

  private

  def calculate_and_create_house_tab_fee(user)
    # Calculate HouseTab fee (3% of total 'unpaid' charges sum)
    total_unpaid_charges = user.charges.unpaid.sum(:amount)
    house_tab_fee_amount = (total_unpaid_charges * 0.03).ceil(2)

    # Convert the house_tab_fee_amount to BigDecimal with two decimal places
    house_tab_fee_amount = BigDecimal(house_tab_fee_amount.to_s)

    # Find or create the HouseTabFee record for the user
    house_tab_fee = HouseTabFee.find_or_create_by(status: 'unpaid', user: user)

    # Update the amount of the HouseTabFee
    house_tab_fee.update(amount: house_tab_fee_amount)

    # Find the HouseTab Fee charge for the user (if it exists)
    house_tab_fee_charge = Charge.find_by(user: user, name: 'HouseTab Fee', bill: nil)

    if house_tab_fee_charge
      # Update the HouseTab Fee charge amount and status
      house_tab_fee_charge.update(amount: house_tab_fee_amount, status: 'unpaid')
    else
      # Create a new Charge record for the HouseTab Fee if it doesn't exist
      user.charges.create(
        amount: house_tab_fee_amount,
        status: 'unpaid',
        name: 'HouseTab Fee',
        bill: nil
      )
    end
  end
end
