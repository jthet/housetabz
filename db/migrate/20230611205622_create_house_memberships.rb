# frozen_string_literal: true

class CreateHouseMemberships < ActiveRecord::Migration[7.0]
  def change
    create_table :house_memberships do |t|
      t.references :house, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
