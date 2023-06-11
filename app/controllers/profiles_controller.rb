class ProfilesController < ApplicationController
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
    params.require(:profile).permit(:first_name, :last_name)
end
end