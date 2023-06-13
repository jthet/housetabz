class ProfilesController < ApplicationController
    
    def new
        @profile = Profile.new
    end

    def create
        @profile = Profile.new(profile_params)
        @profile.user = current_user

    if @profile.save
        redirect_to user_profile_path(current_user)
    else
        render :new
    end
end
    
    def show
        @user = current_user
        @profile = Profile.find(params[:id])

        if @profile.nil?
        end
    end

    def edit 
        @profile = Profile.find(params[:id])
    end

    def update
        @profile = Profile.find(params[:id])
        if @profile.update(profile_params)
        redirect_to @profile
        else  
            render :edit, status: :unprocessable_entity
    end
end


private

def profile_params
    params.require(:profile).permit(:first_name, :last_name, :bio)
end
end