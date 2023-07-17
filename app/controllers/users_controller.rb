class UsersController < ApplicationController
  before_action :check_params, only: :send_notification
  # Other actions...

  def show
    @user = User.find(params[:id])
    @notification = Notification.new
  end

  def send_notification
    @user = User.find(params[:id])
    logger.debug("Notification Params: #{params.inspect}")
    @notification = Notification.new(notification_params)
    @notification.sender_id = current_user.id
    @notification.recipient_id = @user.id
    @notification.read = false

    if @notification.save
      redirect_to @user, notice: 'Notification sent successfully.'
    else
      logger.error("Notification failed to save: #{@notification}")
      logger.error(@notification.errors.full_messages.join(', '))
      render :show
    end
  end

  private

  def notification_params
    params.permit(:message, :recipient_id)
  end
  def check_params
    logger.debug("All Params: #{params.inspect}")
  end
end

