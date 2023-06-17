class DropChargesTable < ActiveRecord::Migration[7.0]
  def change
    drop_table :charges
  end
end
