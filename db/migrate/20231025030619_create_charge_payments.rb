class CreateChargePayments < ActiveRecord::Migration[7.0]
  def change
    create_table :charge_payments do |t|

      t.timestamps
    end
  end
end
