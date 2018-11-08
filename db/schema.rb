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

ActiveRecord::Schema.define(version: 20181104161344) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ascents", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "line_id"
    t.string "style"
    t.date "date"
    t.string "kind"
    t.string "belayer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "points"
    t.index ["line_id"], name: "index_ascents_on_line_id"
    t.index ["user_id"], name: "index_ascents_on_user_id"
  end

  create_table "cities", force: :cascade do |t|
    t.bigint "country_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id"], name: "index_cities_on_country_id"
  end

  create_table "cities_zips", id: false, force: :cascade do |t|
    t.bigint "city_id", null: false
    t.bigint "zip_id", null: false
    t.index ["city_id", "zip_id"], name: "index_cities_zips_on_city_id_and_zip_id"
    t.index ["zip_id", "city_id"], name: "index_cities_zips_on_zip_id_and_city_id"
  end

  create_table "countries", force: :cascade do |t|
    t.string "iso"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lines", force: :cascade do |t|
    t.string "name"
    t.string "grade"
    t.string "crag"
    t.string "kind"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "surname"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "sex"
    t.string "email"
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "city"
    t.string "zip"
    t.decimal "lat", precision: 10, scale: 6
    t.decimal "lng", precision: 10, scale: 6
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "zips", force: :cascade do |t|
    t.string "code"
    t.decimal "lat", precision: 10, scale: 6
    t.decimal "lng", precision: 10, scale: 6
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "ascents", "lines"
  add_foreign_key "ascents", "users"
  add_foreign_key "cities", "countries"
end
