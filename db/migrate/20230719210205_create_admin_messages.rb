# frozen_string_literal: true

class CreateAdminMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :admin_messages do |t|
      t.integer :sender_id
      t.integer :recipient_id
      t.text :message
      t.boolean :read

      t.timestamps
    end
  end
end
