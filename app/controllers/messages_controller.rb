class MessagesController < ApplicationController
  def new
    @message = Message.new
    @recipient_id = params[:user_id]
  end

  def index
    @incoming_messages = current_user.messages.where(read: false)
  end

  def show
    @read_messages = current_user.messages.where(read: true)
  end

  def create
    @message = Message.new(message_params)
  
    if @message.save
      redirect_to member_profile_path(@message.recipient_id), notice: "Message sent successfully."
    else
      render :new
    end
  end

  def mark_as_read
    @message = Message.find(params[:id])
    @message.update(read: true)
    redirect_to root_path, notice: "Message marked as read."

  end

  
  
  private
  
  def message_params
    params.permit(:message, :recipient_id)
  end

end
