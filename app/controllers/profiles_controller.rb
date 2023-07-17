class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def show
    @profile = current_user.profile
    @user = @profile.user
  end
  def new
    @profile = current_user.build_profile
  end

  def create
    @profile = current_user.build_profile(profile_params)
    if @profile.save
      redirect_to house_options_path, notice: 'Profile created successfully.' # Redirect to create/join house page after creating a profile
    else
      render :new
    end
  end

  def edit
    @profile = current_user.profile
  end

  def update
    @profile = current_user.profile
    if @profile.update(profile_params)
      redirect_to house_option_path, notice: 'Profile updated successfully.' # Redirect to create/join house page after updating the profile
    else
      render :edit
    end
  end

  private

  def profile_params
    params.fetch(:profile, {}).permit(:first_name, :last_name, :bio, :profile_picture)
  end
end
