class ChargesController < ApplicationController
  def calculate_charges
    @bills = Bill.all

    current_user.house.users.each do |user|
      user_bills = @bills.select { |bill| bill.user_id == user.id }

      total_charge_in_cents = user_bills.sum { |bill| (bill.calculate_charge * 100 / current_user.house.users.count).round }
      user_charge = total_charge_in_cents / 100.0

      user.charges.create(amount: user_charge, status: 'unpaid')
      calculate_and_create_house_tab_fee(user)
    end
  end

  private

  def calculate_and_create_house_tab_fee(user)
    # Calculate HouseTab fee (3% of total 'unpaid' charges sum)
    total_unpaid_charges = user.charges.unpaid.sum(:amount)
    house_tab_fee_amount = (total_unpaid_charges * 0.03 * 100).round / 100.0

    # Find or create the HouseTabFee record for the user
    house_tab_fee = user.house_tab_fees.find_or_create_by(status: 'unpaid')

    # Update the amount of the HouseTabFee
    house_tab_fee.update(amount: house_tab_fee_amount)

    # Check if a Charge record already exists for the HouseTabFee
    house_tab_fee_charge = Charge.find_by(name: 'HouseTab Fee', bill_id: nil, user_id: user.id)

    if house_tab_fee_charge
      # If a Charge record exists, update the amount
      house_tab_fee_charge.update(amount: house_tab_fee_amount, status: 'unpaid')
    else
      # If no Charge record exists, create a new Charge record for the HouseTabFee
      Charge.create(
        user: user,
        amount: house_tab_fee_amount,
        status: 'unpaid',
        name: 'HouseTab Fee',
        bill: nil # Since this is not related to a specific bill, set bill to nil
      )
    end
  end
end
