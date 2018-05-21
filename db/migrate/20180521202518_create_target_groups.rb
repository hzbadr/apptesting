class CreateTargetGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :target_groups do |t|
      t.string :name
      t.integer :external_id
      t.references :parent, foreign_key: true
      t.string :secret_code
      t.references :panel_provider, foreign_key: true

      t.timestamps
    end
  end
end
