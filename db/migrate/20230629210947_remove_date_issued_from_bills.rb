class RemoveDateIssuedFromBills < ActiveRecord::Migration[7.0]
  def change
    remove_column :bills, :date_issued, :date
  end
end
