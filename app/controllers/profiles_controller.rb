class ProfilesController < ApplicationController
    
    def new
        @profile = Profile.new
    end

    def create
        @profile = Profile.new(profile_params)
        @profile.user = current_user
      
        if @profile.save
          redirect_to user_profile_path(current_user, @profile)
        else
          render :new
        end
      end
      
    
def show
    @user = current_user
    @profile = @user.profile
  
    # You can add additional logic if the profile is nil or not found
    if @profile.nil?
      # Handle the case when the profile is not found
    end
  end
  

    def edit 
      @user = current_user
      @profile = @user.profile
    end

  
    def update
      @user = current_user
      @profile = @user.profile
    
      if @profile.update(profile_params)
        redirect_to user_profile_path(current_user), notice: 'Profile was successfully updated.'
      else
        render :edit
      end
    end
    

  

private

def profile_params
    params.require(:profile).permit(:first_name, :last_name, :bio)
end
end