class DropApplicationRecords < ActiveRecord::Migration[7.0]
  def change
    drop_table :application_records
  end
end
