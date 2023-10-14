class AddTabToCharges < ActiveRecord::Migration[7.0]
  def change
    add_reference :charges, :tab, foreign_key: true
  end
end
