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

ActiveRecord::Schema[7.0].define(version: 2023_10_15_035930) do
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

  create_table "admin_messages", force: :cascade do |t|
    t.integer "sender_id"
    t.integer "recipient_id"
    t.text "message"
    t.boolean "read"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.decimal "amount", precision: 10, scale: 2
    t.decimal "decimal"
    t.integer "house_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "date_issued"
    t.date "due_date"
    t.string "status"
    t.string "bill_image"
    t.boolean "estimated", default: false
    t.integer "tab_id"
    t.index ["house_id"], name: "index_bills_on_house_id"
    t.index ["tab_id"], name: "index_bills_on_tab_id"
  end

  create_table "charge_payments", force: :cascade do |t|
    t.integer "charge_id", null: false
    t.integer "payment_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["charge_id"], name: "index_charge_payments_on_charge_id"
    t.index ["payment_id"], name: "index_charge_payments_on_payment_id"
  end

  create_table "charges", force: :cascade do |t|
    t.integer "user_id", null: false
    t.decimal "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "bill_id"
    t.date "date_issued"
    t.date "due_date"
    t.string "status"
    t.string "name"
    t.boolean "estimated"
    t.integer "tab_id"
    t.index ["bill_id"], name: "index_charges_on_bill_id"
    t.index ["tab_id"], name: "index_charges_on_tab_id"
    t.index ["user_id"], name: "index_charges_on_user_id"
  end

  create_table "contacts", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.text "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "deleted_users", force: :cascade do |t|
    t.string "username"
    t.string "first_name"
    t.string "last_name"
    t.decimal "charges_sum", precision: 10, scale: 2
    t.decimal "payments_sum", precision: 10, scale: 2
    t.decimal "balance_sum", precision: 10, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.decimal "balance"
  end

  create_table "house_memberships", force: :cascade do |t|
    t.integer "house_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["house_id"], name: "index_house_memberships_on_house_id"
    t.index ["user_id"], name: "index_house_memberships_on_user_id"
  end

  create_table "house_tab_fees", force: :cascade do |t|
    t.integer "user_id", null: false
    t.decimal "amount"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_house_tab_fees_on_user_id"
  end

  create_table "houses", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "password_digest"
    t.boolean "joinable", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "members", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.integer "profile_id", null: false
    t.index ["profile_id"], name: "index_members_on_profile_id"
    t.index ["user_id"], name: "index_members_on_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.text "message"
    t.integer "recipient_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "sender_id"
    t.boolean "read"
    t.boolean "admin_message", default: false
  end

  create_table "paid_bills", force: :cascade do |t|
    t.integer "user_id"
    t.integer "bill_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "house_id", null: false
    t.index ["bill_id"], name: "index_paid_bills_on_bill_id"
    t.index ["house_id"], name: "index_paid_bills_on_house_id"
    t.index ["user_id"], name: "index_paid_bills_on_user_id"
  end

  create_table "payments", force: :cascade do |t|
    t.decimal "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
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

  create_table "tabs", force: :cascade do |t|
    t.integer "month"
    t.integer "year"
    t.boolean "paid", default: false
    t.decimal "amount", precision: 10, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "house_id"
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
  add_foreign_key "bills", "tabs"
  add_foreign_key "charge_payments", "charges"
  add_foreign_key "charge_payments", "payments"
  add_foreign_key "charges", "bills"
  add_foreign_key "charges", "tabs"
  add_foreign_key "charges", "users"
  add_foreign_key "house_memberships", "houses"
  add_foreign_key "house_memberships", "users"
  add_foreign_key "house_tab_fees", "users"
  add_foreign_key "members", "profiles"
  add_foreign_key "members", "users"
  add_foreign_key "paid_bills", "bills"
  add_foreign_key "paid_bills", "houses"
  add_foreign_key "paid_bills", "users"
  add_foreign_key "payments", "users"
  add_foreign_key "profiles", "users"
  add_foreign_key "tabs", "houses"
  add_foreign_key "users", "houses"
end
