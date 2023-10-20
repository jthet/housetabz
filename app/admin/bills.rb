ActiveAdmin.register Bill do
  permit_params :name, :amount, :house_id, :bill_image, :due_date

  form do |f|
    f.inputs do
      f.input :name
      f.input :amount
      f.input :house_id, as: :select, collection: House.pluck(:name, :id)
      f.input :due_date
      f.input :bill_image, as: :file
      f.input :estimated, as: :boolean
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
          content_tag(:span, 'No image attached')
        end
      end
    end
  end

  controller do
    def create
      @bill = Bill.new(bill_params)

      if @bill.save
        initialize_tab_for_bill(@bill)
        update_tab_amount(@bill.tab) # Update the tab amount
        redirect_to admin_bills_path, notice: 'Bill was successfully created.'
      else
        puts "Errors: #{@bill.errors}"
        puts "Bill Params: #{bill_params}"
        render :new
      end
    end

    def destroy
      @bill = Bill.find(params[:id])

      # Delete associated charges
      @bill.charges.destroy_all

      # Delete the bill
      @bill.destroy

      update_tab_amount(@bill.tab) # Update the tab amount
      redirect_to admin_bills_path, notice: 'Bill successfully deleted.'
    end

    private

    def initialize_tab_for_bill(bill)
      month = bill.created_at.month
      year = bill.created_at.year

      house_id = bill.house_id # Get the house_id from the bill

      tab = Tab.find_or_create_by(month:, year:, house_id:)
      bill.update(tab:)
    end

    def bill_params
      params.require(:bill).permit(:name, :amount, :house_id, :bill_image, :estimated, :due_date, :tab_id)
    end

    def update_tab_amount(tab)
      total_amount = tab.bills.sum(:amount)
      tab.update(amount: total_amount)
    end
  end
end
