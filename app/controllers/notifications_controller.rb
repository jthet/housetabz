class NotificationsController < ApplicationController
  def new
    @notification = Notification.new
    @recipient_id = params[:user_id]
  end

  def create
    @notification = Notification.new(notification_params)
  
    if @notification.save
      redirect_to member_profile_path(@notification.recipient_id), notice: "Notification sent successfully."
    else
      render :new
    end
  end
  
  private
  
  def notification_params
    params.permit(:message, :recipient_id)
  end
end
