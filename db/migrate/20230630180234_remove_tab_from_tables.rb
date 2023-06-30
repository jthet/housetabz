class RemoveTabFromTables < ActiveRecord::Migration[7.0]
  def change
    remove_column :charges, :tab_id
    remove_column :payments, :tab_id
  

  end
end
