class AddEstimatedToCharges < ActiveRecord::Migration[7.0]
  def change
    add_column :charges, :estimated, :boolean
  end
end
