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

ActiveRecord::Schema[7.0].define(version: 2022_05_31_145303) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "expiry_notifications", force: :cascade do |t|
    t.bigint "ingredient_id", null: false
    t.bigint "fridge_id", null: false
    t.date "exp_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fridge_id"], name: "index_expiry_notifications_on_fridge_id"
    t.index ["ingredient_id"], name: "index_expiry_notifications_on_ingredient_id"
  end

  create_table "fridge_users", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "fridge_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fridge_id"], name: "index_fridge_users_on_fridge_id"
    t.index ["user_id"], name: "index_fridge_users_on_user_id"
  end

  create_table "fridges", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ingredients", force: :cascade do |t|
    t.string "name"
    t.date "exp_date"
    t.string "category"
    t.integer "quantity"
    t.text "comment"
    t.bigint "fridge_id", null: false
    t.string "unit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fridge_id"], name: "index_ingredients_on_fridge_id"
  end

  create_table "invite_notifications", force: :cascade do |t|
    t.string "status"
    t.bigint "sender_user_id", null: false
    t.bigint "receiver_user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["receiver_user_id"], name: "index_invite_notifications_on_receiver_user_id"
    t.index ["sender_user_id"], name: "index_invite_notifications_on_sender_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "expiry_notifications", "fridges"
  add_foreign_key "expiry_notifications", "ingredients"
  add_foreign_key "fridge_users", "fridges"
  add_foreign_key "fridge_users", "users"
  add_foreign_key "ingredients", "fridges"
  add_foreign_key "invite_notifications", "users", column: "receiver_user_id"
  add_foreign_key "invite_notifications", "users", column: "sender_user_id"
end
