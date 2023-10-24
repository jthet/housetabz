# frozen_string_literal: true

class CreateHouses < ActiveRecord::Migration[7.0]
  def change
    create_table :houses do |t|
      t.string :name
      t.string :address
      t.string :password_digest
      t.boolean :joinable, default: false

      t.timestamps
    end
  end
end
