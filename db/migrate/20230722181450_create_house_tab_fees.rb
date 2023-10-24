# frozen_string_literal: true

class CreateHouseTabFees < ActiveRecord::Migration[7.0]
  def change
    create_table :house_tab_fees do |t|
      t.references :user, null: false, foreign_key: true
      t.decimal :amount
      t.string :status

      t.timestamps
    end
  end
end
