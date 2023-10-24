# frozen_string_literal: true

class CreateBalances < ActiveRecord::Migration[7.0]
  def change
    create_table :balances do |t|
      t.decimal :amount
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
