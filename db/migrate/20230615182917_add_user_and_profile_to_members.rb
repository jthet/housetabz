# frozen_string_literal: true

class AddUserAndProfileToMembers < ActiveRecord::Migration[7.0]
  def change
    add_reference :members, :user, null: false, foreign_key: true
    add_reference :members, :profile, null: false, foreign_key: true
  end
end
