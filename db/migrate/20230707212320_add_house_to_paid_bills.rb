class AddHouseToPaidBills < ActiveRecord::Migration[7.0]
  def change
    add_reference :paid_bills, :house, null: false, foreign_key: true
  end
end
