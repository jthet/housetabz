# frozen_string_literal: true

# app/controllers/registrations_controller.rb
class RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(resource)
    new_user_profile_path(resource) # Redirect to create profile page after signing up
  end
end
