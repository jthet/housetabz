class CreateWifiServices < ActiveRecord::Migration[7.0]
  def change
    create_table :wifi_services do |t|

      t.timestamps
    end
  end
end
