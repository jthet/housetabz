# frozen_string_literal: true

class AddAdminMessageToMessages < ActiveRecord::Migration[7.0]
  def change
    add_column :messages, :admin_message, :boolean
  end
end
