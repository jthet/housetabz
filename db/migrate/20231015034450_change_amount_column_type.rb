# frozen_string_literal: true

class ChangeAmountColumnType < ActiveRecord::Migration[7.0]
  def change
    change_column :bills, :amount, :integer
  end
end
