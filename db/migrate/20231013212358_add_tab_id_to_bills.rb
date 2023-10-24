# frozen_string_literal: true

class AddTabIdToBills < ActiveRecord::Migration[6.0]
  def change
    add_reference :bills, :tab, foreign_key: true
  end
end
