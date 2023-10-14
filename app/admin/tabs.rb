ActiveAdmin.register Tab do
    permit_params :month, :year, :house_id, :amount
  
    controller do
  
      def destroy
        @tab = Tab.find(params[:id])
  
        # Add code to ensure only admin users can delete tabs here
  
        # Delete associated bills
        @tab.bills.destroy_all
  
        # Delete the tab
        @tab.destroy
  
        redirect_to admin_tabs_path, notice: 'Tab successfully deleted.'
      end
  
      private
  
      def tab_params
        params.require(:tab).permit(:month, :year, :house_id, :amount)
      end
    end
  
    form do |f|
      f.inputs do
        f.input :month
        f.input :year
        f.input :house_id, as: :select, collection: House.pluck(:name, :id)
        f.input :amount
      end
      f.actions
    end
  
    show do
      attributes_table do
        row :month
        row :year
        row :house_id
        row :amount
      end
    end
  end
  