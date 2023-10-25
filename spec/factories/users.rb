# test/factories/users.rb
FactoryBot.define do
  factory :user do
    username { Faker::Internet.username }
    email { Faker::Internet.email }
    password { 'password123' } # Set a valid password
    created_at { Time.current }
    updated_at { Time.current }
  end
end
