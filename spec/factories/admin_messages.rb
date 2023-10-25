FactoryBot.define do
  factory :admin_message do
    association :sender, factory: :admin_user
    association :recipient, factory: :user
    message { Faker::Lorem.sentence } # Set a valid message
    read { false }
    created_at { Time.current }
    updated_at { Time.current }
  end
end