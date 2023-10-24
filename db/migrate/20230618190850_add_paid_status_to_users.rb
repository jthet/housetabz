# frozen_string_literal: true

class AddPaidStatusToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :paid_status, :boolean, default: false
  end
end
