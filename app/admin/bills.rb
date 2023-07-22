ActiveAdmin.register Bill do
  permit_params :name, :amount, :house_id, :bill_image

  form do |f|
    f.inputs do
      f.input :name
      f.input :amount
      f.input :house_id, as: :select, collection: House.pluck(:name, :id)
      f.input :bill_image, as: :file
    end
    f.actions
  end

  show do
    attributes_table do
      row :name
      row :amount
      row :house_id
      row :bill_image do |bill|
        if bill.bill_image.attached?
          image_tag(bill.bill_image)
        else
          content_tag(:span, "No image attached")
        end
      end
    end
  end

  controller do
    def create
      @bill = Bill.new(bill_params)
  
      if @bill.save
        redirect_to admin_bills_path, notice: 'Bill was successfully created.'
      else
        render :new
      end
  
      # Ensure that the bill has a valid user associated with it before calculating the house tab fee
    end

    def destroy
      @bill = Bill.find(params[:id])

      # Delete associated charges
      @bill.charges.destroy_all

      # Delete the bill
      @bill.destroy

      redirect_to admin_bills_path, notice: 'Bill successfully deleted.'
    end

    private

    def bill_params
      params.require(:bill).permit(:name, :amount, :house_id, :bill_image)
    end
  end
end
