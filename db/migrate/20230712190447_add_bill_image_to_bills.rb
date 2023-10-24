# frozen_string_literal: true

class AddBillImageToBills < ActiveRecord::Migration[7.0]
  def change
    add_column :bills, :bill_image, :string
  end
end
