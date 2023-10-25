# spec/factories/messages.rb

FactoryBot.define do
  factory :message do
    message { "Sample message content" }
    recipient { create(:user) } 
    sender { create(:user) }     
    read { false }
    admin_message { false }

    # Add any additional attributes or associations as needed
  end
end
