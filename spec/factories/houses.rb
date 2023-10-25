# spec/factories/houses.rb
FactoryBot.define do
  factory :house do
    name { 'Example House' } # Add a valid name
    address { '123 Main St' } # Add a valid address
    password_digest { 'hashed_password' }
    joinable { false }
    created_at { Time.current }
    updated_at { Time.current }
  end
end