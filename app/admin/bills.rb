ActiveAdmin.register Bill do
    permit_params :name, :amount, :house_id
  
    form do |f|
      f.inputs do
        f.input :name
        f.input :amount
        f.input :house_id, as: :select, collection: House.pluck(:name, :id)
      end
      f.actions
    end

    controller do
        def create
          @bill = Bill.new(bill_params)
          @bill.house = House.find(params[:bill][:house_id])
    
          if @bill.save
            flash[:notice] = "Thank you! A bill from #{@bill[:name]} has been sent to #{@bill.house[:name]} for a total of #{@bill[:amount]}."
            redirect_to admin_bills_path
          else
            render :new
          end
        end
    
        private
    
        def bill_params
          params.require(:bill).permit(:name, :amount, :house_id)
        end
      end
  end
  