# frozen_string_literal: true

class HomePageController < ApplicationController
  def index
    @contact = Contact.new
    if current_user.nil?
      # Display code for new users or users that have not signed in
      # ...
    elsif current_user.house.nil?
    # Display code for users not associated with any house
    # ...
    else
      # Update user's balance before displaying it
      current_user.balance ||= Balance.create(user: current_user)
      current_user.balance.update(amount: current_user.calculate_balance)

      # Initialize the contact variable
      @incoming_messages = Message.where(recipient_id: current_user.id)

      # Filter admin messages for the current user
      @admin_messages = AdminMessage.where(recipient_id: current_user.id)

      # Render the view
      # ...
    end
  end

  # Other actions...

  def about; end
end
