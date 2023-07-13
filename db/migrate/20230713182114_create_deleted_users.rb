class CreateDeletedUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :deleted_users do |t|
      t.string :username
      t.string :first_name
      t.string :last_name
      t.decimal :charges_sum, precision: 10, scale: 2
      t.decimal :payments_sum, precision: 10, scale: 2
      t.decimal :balance_sum, precision: 10, scale: 2
      t.timestamps
    end
  end
end
