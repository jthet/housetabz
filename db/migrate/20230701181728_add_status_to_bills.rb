class AddStatusToBills < ActiveRecord::Migration[7.0]
  def change
    add_column :bills, :status, :string
  end
end
