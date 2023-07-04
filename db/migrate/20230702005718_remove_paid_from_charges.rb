class RemovePaidFromCharges < ActiveRecord::Migration[7.0]
  def change
    remove_column :charges, :paid, :boolean
  end
end
