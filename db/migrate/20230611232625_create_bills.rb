# frozen_string_literal: true

class CreateBills < ActiveRecord::Migration[7.0]
  def change
    create_table :bills do |t|
      t.string :name
      t.integer :amount
      t.decimal :decimal
      t.references :house, null: false, foreign_key: true

      t.timestamps
    end
  end
end
