class AddStatusToCharges < ActiveRecord::Migration[7.0]
  def change
    add_column :charges, :status, :string
  end
end