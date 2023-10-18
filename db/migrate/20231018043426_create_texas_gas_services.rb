class CreateTexasGasServices < ActiveRecord::Migration[7.0]
  def change
    create_table :texas_gas_services do |t|
      t.string :account_number
      t.timestamps
    end
  end
end
