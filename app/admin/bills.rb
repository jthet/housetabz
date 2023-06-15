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
  end
  