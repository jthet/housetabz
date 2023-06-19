class CheckoutController < ApplicationController
    def create_checkout_session
      # Create line items for the purchase
      line_items = [
        {
          price_data: {
            currency: 'usd',
            product_data: {
              name: 'Product 1',
              description: 'Description of Product 1',
              # Add more product data as needed
            },
            unit_amount: 1000,  # Price in cents
          },
          quantity: 1,  # Adjust quantity as needed
        },
        # Add more line items as needed
      ]
  
      # Create a new Stripe Checkout Session
      session = Stripe::Checkout::Session.create(
        success_url: checkout_success_url,
        cancel_url: checkout_cancel_url,
        payment_method_types: ['card'],
        line_items: line_items,
        mode: 'payment'
      )
  
      # Render the session ID as JSON
      render json: { session_id: session.id }
    end
  
    # ...
  end
  