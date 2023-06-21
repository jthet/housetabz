ActiveAdmin.register User do
  # Columns to display on the index page
  index do
    selectable_column
    id_column
    column :username
    column :email
    column :house
    column :charges
  
    actions
  end

  # Customize the show page
  show do
    attributes_table do
      row :username
      row :email
      row :house
      row :charges
    end
    active_admin_comments
  end

  # Filters for the index page
  filter :username
  filter :email
  filter :house
  filter :charges


  # Permit the necessary attributes for mass assignment
  permit_params :email, :house_id
end
