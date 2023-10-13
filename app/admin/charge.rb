ActiveAdmin.register Charge do
    index do
      selectable_column
      column 'Bill' do |charge|
        "#{charge.bill&.name} $#{charge.amount}"
      end
      column :user
      column :status
      actions
    end
  end
  