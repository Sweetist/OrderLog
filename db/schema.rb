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

ActiveRecord::Schema.define(version: 20170714032356) do

  create_table "bakeries", force: :cascade do |t|
    t.string "name"
    t.string "bakery_type"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_bakeries_on_name", unique: true
  end

  create_table "deliveries", force: :cascade do |t|
    t.integer "delivery_number"
    t.date "week"
    t.date "date"
    t.string "weekday"
    t.time "scheduled_collection"
    t.time "scheduled_delivery"
    t.time "pickup_time"
    t.time "dropoff_time"
    t.boolean "is_on_time"
    t.string "courier_service"
    t.float "courier_fee"
    t.string "state"
    t.string "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "order_id"
    t.index ["delivery_number"], name: "index_deliveries_on_delivery_number", unique: true
    t.index ["order_id"], name: "index_deliveries_on_order_id"
  end

  create_table "line_items", force: :cascade do |t|
    t.integer "variant_id"
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "order_id"
    t.index ["order_id"], name: "index_line_items_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "number"
    t.date "date"
    t.float "subtotal"
    t.float "commission"
    t.float "subtotal_without_commmission"
    t.float "tax"
    t.float "delivery_fee"
    t.float "service_charge"
    t.float "revenue"
    t.float "promotions"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "bakery_id"
    t.integer "recipient_id"
    t.integer "user_id"
    t.index ["bakery_id"], name: "index_orders_on_bakery_id"
    t.index ["recipient_id"], name: "index_orders_on_recipient_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
    t.index [nil], name: "index_orders_on_order_number", unique: true
  end

  create_table "recipients", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "address"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["first_name"], name: "index_recipients_on_first_name"
    t.index ["last_name"], name: "index_recipients_on_last_name"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "authentication_token", limit: 30
    t.index ["authentication_token"], name: "index_users_on_authentication_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
