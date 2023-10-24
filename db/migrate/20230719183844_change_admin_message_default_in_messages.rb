# frozen_string_literal: true

class ChangeAdminMessageDefaultInMessages < ActiveRecord::Migration[7.0]
  def change
    change_column_default :messages, :admin_message, false
  end
end
