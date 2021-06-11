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

ActiveRecord::Schema.define(version: 2021_06_09_204609) do

  create_table "barcode_symbologies", charset: "utf8", force: :cascade do |t|
    t.string "code", null: false
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["code"], name: "index_barcode_symbologies_on_code", unique: true
    t.index ["name"], name: "index_barcode_symbologies_on_name", unique: true
  end

  create_table "bundle_transactions", charset: "utf8", force: :cascade do |t|
    t.bigint "bundle_id", null: false
    t.integer "transaction_type"
    t.bigint "logged_by_id", null: false
    t.bigint "executed_by_id", null: false
    t.bigint "transferee_id"
    t.integer "quantity", null: false
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["bundle_id"], name: "index_bundle_transactions_on_bundle_id"
    t.index ["executed_by_id"], name: "index_bundle_transactions_on_executed_by_id"
    t.index ["logged_by_id"], name: "index_bundle_transactions_on_logged_by_id"
    t.index ["transferee_id"], name: "index_bundle_transactions_on_transferee_id"
  end

  create_table "bundles", charset: "utf8", force: :cascade do |t|
    t.string "bundle_number", null: false
    t.integer "status", default: 1, null: false
    t.integer "current_quantity", default: 0, null: false
    t.integer "initial_quantity", default: 0, null: false
    t.bigint "current_assignee_id"
    t.bigint "loaded_by_id"
    t.timestamp "loaded_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "parent_bundle_id"
    t.timestamp "deleted_at"
    t.bigint "deleted_by_id"
    t.timestamp "released_at"
    t.boolean "released", default: false, null: false
    t.index ["bundle_number"], name: "index_bundles_on_bundle_number", unique: true
    t.index ["current_assignee_id"], name: "index_bundles_on_current_assignee_id"
    t.index ["deleted_by_id"], name: "index_bundles_on_deleted_by_id"
    t.index ["loaded_by_id"], name: "index_bundles_on_loaded_by_id"
    t.index ["parent_bundle_id"], name: "index_bundles_on_parent_bundle_id"
  end

  create_table "campaigns", charset: "utf8", force: :cascade do |t|
    t.string "title", null: false
    t.string "description", limit: 2000
    t.bigint "created_by_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["created_by_id"], name: "index_campaigns_on_created_by_id"
  end

  create_table "cards", charset: "utf8", force: :cascade do |t|
    t.string "card_number", null: false
    t.bigint "bundle_id", null: false
    t.integer "status", default: 1, null: false
    t.timestamp "sold_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["bundle_id"], name: "index_cards_on_bundle_id"
    t.index ["card_number"], name: "index_cards_on_card_number", unique: true
  end

  create_table "users", charset: "utf8", force: :cascade do |t|
    t.string "email"
    t.string "mobile_number"
    t.string "password_digest", null: false
    t.string "first_name"
    t.string "surname"
    t.timestamp "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "manager_id"
    t.integer "user_role", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["manager_id"], name: "index_users_on_manager_id"
    t.index ["mobile_number"], name: "index_users_on_mobile_number", unique: true
  end

  add_foreign_key "bundle_transactions", "bundles"
  add_foreign_key "bundle_transactions", "users", column: "executed_by_id"
  add_foreign_key "bundle_transactions", "users", column: "logged_by_id"
  add_foreign_key "bundle_transactions", "users", column: "transferee_id"
  add_foreign_key "bundles", "bundles", column: "parent_bundle_id"
  add_foreign_key "bundles", "users", column: "current_assignee_id"
  add_foreign_key "bundles", "users", column: "deleted_by_id"
  add_foreign_key "bundles", "users", column: "loaded_by_id"
  add_foreign_key "campaigns", "users", column: "created_by_id"
  add_foreign_key "cards", "bundles"
  add_foreign_key "users", "users", column: "manager_id"
end
