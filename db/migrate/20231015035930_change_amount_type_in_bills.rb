# frozen_string_literal: true

class ChangeAmountTypeInBills < ActiveRecord::Migration[7.0]
  def change
    change_column :bills, :amount, :decimal, precision: 10, scale: 2
  end
end
