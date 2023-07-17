class CreateNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :notifications do |t|
      t.text :message
      t.integer :recipient_id

      t.timestamps
    end
  end
end
