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

ActiveRecord::Schema[7.0].define(version: 2023_06_11_232625) do
  create_table "bills", force: :cascade do |t|
    t.string "name"
    t.string "amount"
    t.string "decimal"
    t.integer "house_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["house_id"], name: "index_bills_on_house_id"
  end

  create_table "house_memberships", force: :cascade do |t|
    t.integer "house_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["house_id"], name: "index_house_memberships_on_house_id"
    t.index ["user_id"], name: "index_house_memberships_on_user_id"
  end

  create_table "houses", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "password_digest"
    t.boolean "joinable"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "profiles", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "first_name"
    t.string "last_name"
    t.text "bio"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "house_id"
    t.string "first_name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["house_id"], name: "index_users_on_house_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "bills", "houses"
  add_foreign_key "house_memberships", "houses"
  add_foreign_key "house_memberships", "users"
  add_foreign_key "profiles", "users"
  add_foreign_key "users", "houses"
end
