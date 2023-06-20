class CheckoutController < ApplicationController
  def create_checkout_session
    # Get the price from the user input (assuming it's submitted as a form parameter named 'price')
    custom_price = params[:price].to_f

    if custom_price <= 0
      render json: { error: 'Invalid price. Please enter a valid price greater than zero.' }, status: :unprocessable_entity
      return
    end

    cancel_url = 'http://localhost:3000/checkout'  # Replace with your cancel URL
    success_url = 'http://localhost:3000/checkout_success'  # Replace with your success URL

    # Create a new Stripe Checkout Session
    session = Stripe::Checkout::Session.create(
      success_url: success_url,
      cancel_url: cancel_url,
      payment_method_types: ['card'],
      line_items: [{
        price_data: {
          currency: 'usd',  # Replace 'usd' with the appropriate currency code
          product_data: {
            name: 'HouseTabz services'  # Replace with the actual product name
          },
          unit_amount: (custom_price * 100).to_i  # Convert the price to cents
        },
        quantity: 1
      }],
      mode: 'payment'
    )

    # Return the session ID to the client
    render json: { id: session.id }
  rescue Stripe::StripeError => e
    # Handle any Stripe errors
    render json: { error: e.message }, status: :unprocessable_entity
  end

  # ...
end
