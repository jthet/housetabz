# frozen_string_literal: true

class CreatePaidBills < ActiveRecord::Migration[7.0]
  def change
    create_table :paid_bills do |t|
      t.references :user, foreign_key: true
      t.references :bill, foreign_key: true

      t.timestamps
    end
  end
end
