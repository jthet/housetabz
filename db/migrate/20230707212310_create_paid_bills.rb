class CreatePaidBills < ActiveRecord::Migration[7.0]
  def change
    create_table :paid_bills do |t|

      t.timestamps
    end
  end
end
