# app/controllers/registrations_controller.rb
class RegistrationsController < Devise::RegistrationsController
    protected
  
    def after_sign_up_path_for(resource)
      resource.create_profile
      root_path 
    end
  end
  