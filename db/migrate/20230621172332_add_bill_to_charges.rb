class AddBillToCharges < ActiveRecord::Migration[7.0]
  def change
    add_reference :charges, :bill, foreign_key: true
  end
end
