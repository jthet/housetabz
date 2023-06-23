class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def stripe
    payload = request.body.read
    sig_header = request.env['HTTP_STRIPE_SIGNATURE']
    event = nil

    # Verify the signature
    begin
      event = Stripe::Webhook.construct_event(payload, sig_header, webhook_secret)
    rescue JSON::ParserError, Stripe::SignatureVerificationError => e
      # Invalid payload or signature
      return head :bad_request
    end

    # Process the event
    case event.type
    when 'payment_intent.succeeded'
      user_id = extract_user_id_from_payment_intent(event)
      custom_price = extract_custom_price_from_payment_intent(event)
      handle_successful_payment(user_id, custom_price)
    else
      # Ignore unsupported events
      head :ok
    end
  end

  private

  def webhook_secret
    # Replace this with your actual webhook secret
<<<<<<< HEAD
    
    ENV['WEBHOOK_SECRET'].to_s
  
=======
    # 'whsec_gXf09BxaIyJ4YUqzsQWrQXUfo4mWjnQT'
    ENV['WEBHOOK_SECRET'].to_s
    # 'whsec_T7RPRmkrQWg9SuVCCudUFQZP7qg5BkVY'
>>>>>>> 891eaaf40111eec2bbf8366df4a336f5a03b4b0e
  end

  def extract_user_id_from_payment_intent(event)
    payment_intent = event.data.object
    description = payment_intent.description
    extract_user_id_from_description(description)
  end

  def extract_custom_price_from_payment_intent(event)
    payment_intent = event.data.object
    amount_paid = payment_intent.amount_received / 100.0
    amount_paid
  end

  def extract_user_id_from_description(description)
    match = /user_id=(\d+)/.match(description)
    match[1].to_i if match
  end

  def handle_successful_payment(user_id, custom_price)
    puts "Handling successful payment..."
    puts "User ID: #{user_id}"
    puts "Custom Price: #{custom_price}"
    amount_paid = custom_price

    Payment.create(user_id: user_id, amount: amount_paid)
    puts "User: #{user_id}"
    puts "Amount im a kitty: #{amount_paid}"
  end

  # Make the handle_successful_payment method accessible from outside
  public :handle_successful_payment
end
