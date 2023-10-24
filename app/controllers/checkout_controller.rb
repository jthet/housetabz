class CheckoutController < ApplicationController
  def create_checkout_session
    custom_price = params[:price].to_f
    user_id = current_user.id

    puts "Custom Price: #{custom_price}"
    puts "User ID: #{user_id}"

    if custom_price <= 0
      render json: { error: 'Invalid price. Please enter a valid price greater than zero.' },
             status: :unprocessable_entity
      return
    end

    cancel_url = 'http://127.0.0.1:3000/checkout' # Replace with your cancel URL
    success_url = "http://127.0.0.1:3000/checkout_success?user_id=#{user_id}&price=#{custom_price}"
    # success_url = "https://50c8-2600-387-f-7113-00-9.ngrok-free.app/checkout_success?user_id=#{user_id}&price=#{custom_price}"


    session = Stripe::Checkout::Session.create(
      success_url: success_url,
      cancel_url: cancel_url,
      payment_method_types: ['card'],
      metadata: {
        user_id: user_id.to_s
      },
      line_items: [{
        price_data: {
          currency: 'usd', # Replace 'usd' with the appropriate currency code
          product_data: {
            name: 'HouseTabz services' # Replace with the actual product name
          },
          unit_amount: (custom_price * 100).to_i # Convert the price to cents
        },
        quantity: 1
      }],
      mode: 'payment'
    )

    render json: { id: session.id }
    
    rescue Stripe::StripeError => e
      puts "Stripe Error: #{e.message}"
      render json: { error: e.message }, status: :unprocessable_entity
    end

    def checkout_success
      user_id = params[:user_id].to_i
      custom_price = params[:price].to_f

      webhooks_controller = WebhooksController.new
      webhooks_controller.handle_successful_payment(user_id, custom_price)

      render 'checkout/checkout_success'
    end
end