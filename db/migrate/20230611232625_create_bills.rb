class CreateBills < ActiveRecord::Migration[7.0]
  def change
    create_table :bills do |t|
      t.string :name
      t.string :amount
      t.string :decimal
      t.references :house, null: false, foreign_key: true

      t.timestamps
    end
  end
end
