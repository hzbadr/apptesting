class CreateLocationGroupsLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :location_groups_locations do |t|
      t.references :location, foreign_key: true
      t.references :location_group, foreign_key: true
    end
  end
end
