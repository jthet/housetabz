# frozen_string_literal: true

class AddHouseToUsers < ActiveRecord::Migration[7.0]
  def change
    add_reference :users, :house, foreign_key: true
  end
end
