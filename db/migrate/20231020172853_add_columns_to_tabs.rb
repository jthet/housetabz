# frozen_string_literal: true

class AddColumnsToTabs < ActiveRecord::Migration[7.0]
  def change
    add_column :tabs, :user, :string
    add_column :tabs, :total_charges, :decimal
    add_column :tabs, :total_payments, :decimal
  end
end
