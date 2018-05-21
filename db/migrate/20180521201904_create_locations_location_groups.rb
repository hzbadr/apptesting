class CreateLocationsLocationGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :locations_location_groups do |t|
      t.references :location, foreign_key: true
      t.references :location_groups, foreign_key: true
    end
  end
end
