class HomePageController < ApplicationController
  before_action :authenticate_user!
  def index
    @contact = Contact.new
    @admin_messages = current_user.admin_messages.where(recipient_id: current_user.id)
    if current_user.nil?
      # Display code for new users or users that have not signed in
      # ...
    else
      if current_user.house.nil?
        # Display code for users not associated with any house
        # ...
      else
        # Update user's balance before displaying it
        current_user.balance ||= Balance.create(user: current_user)
        current_user.balance.update(amount: current_user.calculate_balance)
  
        # Initialize the contact variable
        @incoming_messages = Message.where(recipient_id: current_user.id)
      end

      # Render the view
      # ...
    end
  end

  def about
    # Your about action code here
  end
end
