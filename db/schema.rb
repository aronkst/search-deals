# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_06_04_160411) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "sale_groups", force: :cascade do |t|
    t.bigint "scraper_id", null: false
    t.boolean "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["scraper_id"], name: "index_sale_groups_on_scraper_id"
  end

  create_table "sales", force: :cascade do |t|
    t.bigint "sale_group_id", null: false
    t.string "title"
    t.float "value"
    t.integer "porcentage"
    t.string "image"
    t.string "link"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sale_group_id"], name: "index_sales_on_sale_group_id"
  end

  create_table "scraper_attributes", force: :cascade do |t|
    t.bigint "scraper_id", null: false
    t.text "value", null: false
    t.text "tags", null: false
    t.string "html"
    t.text "replace"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["scraper_id"], name: "index_scraper_attributes_on_scraper_id"
    t.index ["value", "scraper_id"], name: "index_scraper_attributes_on_value_and_scraper_id", unique: true
  end

  create_table "scrapers", force: :cascade do |t|
    t.string "name", null: false
    t.string "url", null: false
    t.integer "pages", null: false
    t.integer "value", null: false
    t.integer "porcentage", null: false
    t.text "html", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "sale_groups", "scrapers"
  add_foreign_key "sales", "sale_groups"
  add_foreign_key "scraper_attributes", "scrapers"
end
