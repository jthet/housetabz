# app/controllers/registrations_controller.rb
class RegistrationsController < Devise::RegistrationsController
  # def create
  #   super do |resource|
  #     # Custom code to create a customer in Stripe and associate the user ID
  #     customer = Stripe::Customer.create(email: resource.email, metadata: {user_id: resource.id})
  #   end
  # end

  protected

  def after_sign_up_path_for(resource)
    new_user_profile_path(resource) # Redirect to create profile page after signing up
  end
end
