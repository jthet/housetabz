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
    ENV['WEBHOOK_SECRET'].to_s
  end

  def extract_user_id_from_payment_intent(event)
    payment_intent = event.data.object
    description = payment_intent.description
    extract_user_id_from_description(description)
  end

  def extract_custom_price_from_payment_intent(event)
    payment_intent = event.data.object
    payment_intent.amount_received / 100.0
  end

  def extract_user_id_from_description(description)
    match = /user_id=(\d+)/.match(description)
    match[1].to_i if match
  end

  def handle_successful_payment(user_id, custom_price)
    puts 'Handling successful payment...'
    puts "User ID: #{user_id}"
    puts "Custom Price: #{custom_price}"
    amount_paid = custom_price

    begin
      # Retrieve the user and their charges
      user = User.find(user_id)
      charges_to_cover = user.charges.reload.where(status: 'unpaid')

      # Update the status of the charges if all charge payments have been made
      charges_to_cover.each do |charge|
        charge.update(status: 'paid') if charge.payments.count == charge.charge_payments.count
      end

      # Create the payment record
      payment = Payment.create(user_id: user_id, amount: amount_paid)

      # Associate the charges with the payment
      charges_to_cover.each do |charge|
        ChargePayment.create(payment: payment, charge: charge)
      end

      # Update the paid status of the user
      user.update_paid_status

      puts "User: #{user_id}"
      puts "Amount: #{amount_paid}"
    rescue ActiveRecord::RecordNotFound => e
      puts "User not found with ID: #{user_id}"
      # You can add additional error handling or logging here if needed
    end
  end
  # Make the handle_successful_payment method accessible from outside
  public :handle_successful_payment
end
