# frozen_string_literal: true

class AddNetworkNameToWifiServices < ActiveRecord::Migration[7.0]
  def change
    add_column :wifi_services, :network_name, :string
  end
end
