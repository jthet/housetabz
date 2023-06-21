class CreateCharges < ActiveRecord::Migration[7.0]
  def change
    create_table :charges do |t|
      t.references :user, null: false, foreign_key: true
      t.decimal :amount
      t.boolean :paid

      t.timestamps
    end
  end
end
