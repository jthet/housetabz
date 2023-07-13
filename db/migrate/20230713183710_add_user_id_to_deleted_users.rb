class AddUserIdToDeletedUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :deleted_users, :user_id, :integer
  end
end
