# frozen_string_literal: true

class CreateChargePayments < ActiveRecord::Migration[7.0]
  def change
    create_table :charge_payments do |t|
      t.references :charge, null: false, foreign_key: true
      t.references :payment, null: false, foreign_key: true

      t.timestamps
    end
  end
end
