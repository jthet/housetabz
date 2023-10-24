# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :check_params, only: :send_message
  # Other actions...

  def show
    @user = User.find(params[:id])
    @message = Message.new
  end

  def send_message
    @user = User.find(params[:id])
    logger.debug("messageParams: #{params.inspect}")
    @message = Message.new(message_params)
    @message.sender_id = current_user.id
    @message.recipient_id = @user.id
    @message.read = false

    if @message.save
      redirect_to @user, notice: 'message sent successfully.'
    else
      logger.error("message failed to save: #{@message}")
      logger.error(@message.errors.full_messages.join(', '))
      render :show
    end
  end

  def mark_as_read
    @admin_message = AdminMessage.find(params[:id])
    @admin_message.update(read: true)
    redirect_to root_path, notice: 'Message marked as read.'
  end

  private

  def message_params
    params.permit(:message, :recipient_id)
  end

  def check_params
    logger.debug("All Params: #{params.inspect}")
  end
end
