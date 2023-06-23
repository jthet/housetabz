class CheckoutController < ApplicationController
  def create_checkout_session
    custom_price = params[:price].to_f
    user_id = current_user.id

    puts "Custom Price: #{custom_price}"
    puts "User ID: #{user_id}"

    if custom_price <= 0
      render json: { error: 'Invalid price. Please enter a valid price greater than zero.' }, status: :unprocessable_entity
      return
    end

<<<<<<< HEAD
    cancel_url = 'https://048b-2600-1700-290-5680-30f6-ef7c-e434-7e9c.ngrok-free.app/checkout'  # Replace with your cancel URL
    success_url = "https://048b-2600-1700-290-5680-30f6-ef7c-e434-7e9c.ngrok-free.app/checkout_success?user_id=#{user_id}&price=#{custom_price}"
=======
    cancel_url = 'https://8ec7-2600-1700-290-5680-9009-d26d-f571-cd4d.ngrok-free.app//checkout'  # Replace with your cancel URL
    success_url = "https://8ec7-2600-1700-290-5680-9009-d26d-f571-cd4d.ngrok-free.app/checkout_success?user_id=#{user_id}&price=#{custom_price}"
>>>>>>> 891eaaf40111eec2bbf8366df4a336f5a03b4b0e
    
    session = Stripe::Checkout::Session.create(
      success_url: success_url,
      cancel_url: cancel_url,
      payment_method_types: ['card'],
      metadata: {
        user_id: user_id.to_s
      },
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

    render json: { id: session.id }
  rescue Stripe::StripeError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def checkout_success
    user_id = params[:user_id].to_i
    custom_price = params[:price].to_f
    
    webhooks_controller = WebhooksController.new
    webhooks_controller.handle_successful_payment(user_id, custom_price)

    render 'checkout/checkout_success'
  end
  def checkout_success
    user_id = params[:user_id].to_i
    custom_price = params[:price].to_f
    
    webhooks_controller = WebhooksController.new
    webhooks_controller.handle_successful_payment(user_id, custom_price)

    render 'checkout/checkout_success'
  end
end
