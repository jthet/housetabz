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

<<<<<<< HEAD
ActiveRecord::Schema[7.0].define(version: 2023_06_23_155119) do
=======
ActiveRecord::Schema[7.0].define(version: 2023_06_21_195135) do
>>>>>>> 891eaaf40111eec2bbf8366df4a336f5a03b4b0e
  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.integer "resource_id"
    t.string "author_type"
    t.integer "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource"
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "balances", force: :cascade do |t|
    t.decimal "amount"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_balances_on_user_id"
  end

  create_table "bills", force: :cascade do |t|
    t.string "name"
    t.string "amount"
    t.string "decimal"
    t.integer "house_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["house_id"], name: "index_bills_on_house_id"
  end

  create_table "charges", force: :cascade do |t|
    t.integer "user_id", null: false
    t.decimal "amount"
    t.boolean "paid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "bill_id", null: false
    t.index ["bill_id"], name: "index_charges_on_bill_id"
    t.index ["user_id"], name: "index_charges_on_user_id"
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

  create_table "members", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.integer "profile_id", null: false
    t.integer "house_id", null: false
    t.index ["house_id"], name: "index_members_on_house_id"
    t.index ["profile_id"], name: "index_members_on_profile_id"
    t.index ["user_id"], name: "index_members_on_user_id"
  end

  create_table "payments", force: :cascade do |t|
    t.decimal "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_payments_on_user_id"
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
    t.float "divided_amount"
    t.boolean "admin", default: false
    t.string "username"
    t.boolean "paid_status", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["house_id"], name: "index_users_on_house_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "balances", "users"
  add_foreign_key "bills", "houses"
  add_foreign_key "charges", "bills"
  add_foreign_key "charges", "users"
  add_foreign_key "house_memberships", "houses"
  add_foreign_key "house_memberships", "users"
  add_foreign_key "members", "houses"
  add_foreign_key "members", "profiles"
  add_foreign_key "members", "users"
  add_foreign_key "payments", "users"
  add_foreign_key "profiles", "users"
  add_foreign_key "users", "houses"
end
