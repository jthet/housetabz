class AddDividedAmountToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :divided_amount, :float
  end
end
