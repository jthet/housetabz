class AddTabTable < ActiveRecord::Migration[6.0]
  def change
    create_table :tabs do |t|
      t.integer :month
      t.integer :year
      t.boolean :paid, default: false
      t.decimal :amount, precision: 10, scale: 2

      # Add any additional columns you want for the Tab model

      t.timestamps
    end
  end
end
