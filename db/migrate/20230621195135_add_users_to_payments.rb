class AddUsersToPayments < ActiveRecord::Migration[7.0]
  def change
    add_reference :payments, :user, foreign_key: true
  end
end
