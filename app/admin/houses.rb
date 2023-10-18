ActiveAdmin.register House do
    permit_params :name, :address
  
    show do
      attributes_table do
        row :name
        row :address
        # Add any other attributes you want to display here
      end
  
      panel "Users" do
        table_for house.users do
          column :name
          column :email
          # Add any other user attributes you want to display here
        end
      end
  
      panel "Bills" do
        table_for house.bills do
          column :name
          column :amount
          column :status
          # Add any other bill attributes you want to display here
        end
      end
    end
  
    form do |f|
      f.inputs "House Details" do
        f.input :name
        f.input :address
        # Add any other house attributes you want to edit here
      end
      f.actions
    end
  end
  