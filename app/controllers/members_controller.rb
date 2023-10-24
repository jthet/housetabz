# frozen_string_literal: true

class MembersController < ApplicationController
  def show
    @member = Profile.find(params[:id])
    #   @profile = @member.profile
    @user = @member.user
    @incoming_messages = Message.where(recipient: current_user, sender: @user)
  end
end
