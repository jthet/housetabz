class AddHouseIdToTabs < ActiveRecord::Migration[6.0]
  def change
    add_column :tabs, :house_id, :integer
    add_foreign_key :tabs, :houses
  end
end
