# spec/factories/admin_users.rb
FactoryBot.define do
  factory :admin_user do
    email { Faker::Internet.email } # Use Faker gem for random email generation
    password { "password123" } # Set a default password
    created_at { Time.current }
    updated_at { Time.current }
  end
end

