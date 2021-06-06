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

ActiveRecord::Schema.define(version: 2021_06_06_141256) do

  create_table "barcode_symbologies", charset: "utf8", force: :cascade do |t|
    t.string "code", null: false
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["code"], name: "index_barcode_symbologies_on_code", unique: true
    t.index ["name"], name: "index_barcode_symbologies_on_name", unique: true
  end

  create_table "card_bundle_transactions", charset: "utf8", force: :cascade do |t|
    t.bigint "card_bundle_id", null: false
    t.integer "transaction_type"
    t.bigint "src_id", null: false
    t.bigint "dest_id", null: false
    t.integer "card_quantity"
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["card_bundle_id"], name: "index_card_bundle_transactions_on_card_bundle_id"
    t.index ["dest_id"], name: "index_card_bundle_transactions_on_dest_id"
    t.index ["src_id"], name: "index_card_bundle_transactions_on_src_id"
  end

  create_table "card_bundles", charset: "utf8", force: :cascade do |t|
    t.string "bundle_number", null: false
    t.integer "status", default: 1, null: false
    t.integer "card_quantity", null: false
    t.bigint "current_assignee_id"
    t.bigint "loaded_by_id"
    t.timestamp "loaded_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "parent_bundle_id"
    t.index ["bundle_number"], name: "index_card_bundles_on_bundle_number", unique: true
    t.index ["current_assignee_id"], name: "index_card_bundles_on_current_assignee_id"
    t.index ["loaded_by_id"], name: "index_card_bundles_on_loaded_by_id"
    t.index ["parent_bundle_id"], name: "index_card_bundles_on_parent_bundle_id"
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
    t.bigint "owner_id"
    t.integer "user_role", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["mobile_number"], name: "index_users_on_mobile_number", unique: true
    t.index ["owner_id"], name: "index_users_on_owner_id"
  end

  add_foreign_key "card_bundle_transactions", "card_bundles"
  add_foreign_key "card_bundle_transactions", "users", column: "dest_id"
  add_foreign_key "card_bundle_transactions", "users", column: "src_id"
  add_foreign_key "card_bundles", "users", column: "current_assignee_id"
  add_foreign_key "card_bundles", "users", column: "loaded_by_id"
  add_foreign_key "card_bundles", "users", column: "parent_bundle_id"
  add_foreign_key "cards", "card_bundles", column: "bundle_id"
  add_foreign_key "users", "users", column: "owner_id"
end
