class AddDateIssuedToBills < ActiveRecord::Migration[7.0]
  def change
    add_column :bills, :date_issued, :date
  end
end
