class AddBalanceToDeletedUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :deleted_users, :balance, :decimal
  end
end
