# frozen_string_literal: true

class AddEstimatedToBills < ActiveRecord::Migration[7.0]
  def change
    add_column :bills, :estimated, :boolean, default: false
  end
end
