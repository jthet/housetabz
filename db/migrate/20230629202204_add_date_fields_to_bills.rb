class AddDateFieldsToBills < ActiveRecord::Migration[7.0]
  def change
    add_column :bills, :date_issued, :date
    add_column :bills, :due_date, :date
  end
end
