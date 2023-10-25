class CreateCityOfAustinUtilitiesServices < ActiveRecord::Migration[7.0]
  def change
    create_table :city_of_austin_utilities_services do |t|

      t.timestamps
    end
  end
end
