class CreateCityOfAustinUtilitiesServices < ActiveRecord::Migration[6.0]
  def change
    create_table :city_of_austin_utilities_services do |t|
      t.string :account_number
      # Add other columns as needed
      t.timestamps
    end
  end
end
