class NotificationsController < ApplicationController
  def new
    @notification = Notification.new
    @recipient_id = params[:user_id]
  end

  def index
    @incoming_messages = current_user.notifications.where(read: false)
  end

  def show
    @read_messages = current_user.notifications.where(read: true)
  end

  def create
    @notification = Notification.new(notification_params)
  
    if @notification.save
      redirect_to member_profile_path(@notification.recipient_id), notice: "Notification sent successfully."
    else
      render :new
    end
  end

  def mark_as_read
    @notification = Notification.find(params[:id])
    @notification.update(read: true)
    redirect_to root_path, notice: "Notification marked as read."

  end
  
  private
  
  def notification_params
    params.permit(:message, :recipient_id)
  end
end
