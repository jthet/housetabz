class MembersController < ApplicationController
    def show
      @member = Profile.find(params[:id])
    #   @profile = @member.profile
      @user = @member.user
    end
  end
  