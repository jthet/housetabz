class ChargesController < ApplicationController
  def calculate_charges
    @bills = Bill.all

    current_user.house.users.each do |user|
      user_bills = @bills.select { |bill| bill.user_id == user.id }

      user_bills.each do |bill|
        total_charge_in_cents = (bill.calculate_charge * 100 / current_user.house.users.count).round
        user_charge = total_charge_in_cents / 100.0

        user_charge = BigDecimal(user_charge.to_s).ceil(2).to_f

        # Check if the associated bill is estimated and set the charge's estimated attribute accordingly
        estimated = bill.estimated

        user.charges.create(amount: user_charge, status: 'unpaid', estimated: estimated)

        calculate_and_create_house_tab_fee(user)
      end
    end
  end

  def send_reminder
    charge = Charge.find(params[:id])
    user = charge.user

    # Create a message
    message = user.messages.build(
      content: params[:reminder_message],
      sender_id: current_user.id,
      recipient_id: user.id
    )

    if message.save
      # Update the charge to indicate a reminder was sent
      charge.update(reminder_sent: true)

      flash[:success] = "Reminder sent successfully!"
    else
      flash[:error] = "Error sending reminder"
    end

    redirect_to :back
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
        bill: nil,
        estimated: false
      )
    end
  end
end
