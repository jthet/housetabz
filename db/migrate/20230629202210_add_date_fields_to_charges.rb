class AddDateFieldsToCharges < ActiveRecord::Migration[7.0]
  def change
    add_column :charges, :date_issued, :date
    add_column :charges, :due_date, :date
  end
end
