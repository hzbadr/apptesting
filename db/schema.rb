# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_05_23_022208) do

  create_table "countries", force: :cascade do |t|
    t.string "country_code"
    t.integer "panel_provider_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["panel_provider_id"], name: "index_countries_on_panel_provider_id"
  end

  create_table "location_groups", force: :cascade do |t|
    t.string "name"
    t.integer "country_id"
    t.integer "panel_provider_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id"], name: "index_location_groups_on_country_id"
    t.index ["panel_provider_id"], name: "index_location_groups_on_panel_provider_id"
  end

  create_table "location_groups_locations", force: :cascade do |t|
    t.integer "location_id"
    t.integer "location_group_id"
    t.index ["location_group_id"], name: "index_location_groups_locations_on_location_group_id"
    t.index ["location_id"], name: "index_location_groups_locations_on_location_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "name"
    t.integer "external_id"
    t.string "secret_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "panel_providers", force: :cascade do |t|
    t.string "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "target_groups", force: :cascade do |t|
    t.string "name"
    t.integer "external_id"
    t.integer "parent_id"
    t.string "secret_code"
    t.integer "panel_provider_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["panel_provider_id"], name: "index_target_groups_on_panel_provider_id"
    t.index ["parent_id"], name: "index_target_groups_on_parent_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
