class ChangeAmountColumnTypeInBills < ActiveRecord::Migration[6.1] # or your corresponding Rails version
  def up
    change_column :bills, :amount, 'decimal USING CAST(amount AS decimal)', precision: 8, scale: 2
  end
  
  def down
    change_column :bills, :amount, :string
  end
end