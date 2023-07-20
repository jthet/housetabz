ActiveAdmin.register AdminMessage do
    permit_params :sender_id, :recipient_id, :message
  
    form do |f|
      f.inputs "Admin Message Details" do
        f.input :recipient, as: :select, collection: User.all.map { |user| [user.email, user.id] }
        f.input :message, as: :text
      end
      f.actions
    end
  
    controller do
      def create
        @admin_message = AdminMessage.new(permitted_params[:admin_message])
        @admin_message.sender = current_admin_user
  
        if @admin_message.save
          redirect_to admin_admin_message_path(@admin_message), notice: "Admin message sent successfully."
        else
          render :new
        end
      end
  

    end
    
  end
  