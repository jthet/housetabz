# frozen_string_literal: true

class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.text :message
      t.integer :recipient_id

      t.timestamps
    end
  end
end
