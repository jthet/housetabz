# frozen_string_literal: true

class AddNameToCharges < ActiveRecord::Migration[7.0]
  def change
    add_column :charges, :name, :string
  end
end
