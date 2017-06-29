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

ActiveRecord::Schema.define(version: 20170627234904) do

  create_table "bakeries", force: :cascade do |t|
    t.string "name"
    t.string "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.float "courer_fee"
    t.string "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.integer "order_number"
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
  end

  create_table "recipients", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
