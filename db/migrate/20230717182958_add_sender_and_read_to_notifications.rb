class AddSenderAndReadToNotifications < ActiveRecord::Migration[7.0]
  def change
    add_column :notifications, :sender_id, :integer
    add_column :notifications, :read, :boolean
  end
end
