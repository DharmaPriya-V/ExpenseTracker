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

ActiveRecord::Schema.define(version: 2021_07_18_201646) do

  create_table "comments", force: :cascade do |t|
    t.integer "detail_id"
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "parent_id"
    t.integer "user_id"
  end

  create_table "details", force: :cascade do |t|
    t.string "allowance"
    t.date "date"
    t.decimal "amount"
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id"
    t.integer "invoiceno"
    t.integer "expensegroup_id"
    t.string "bills"
    t.integer "approval", default: 0
    t.boolean "system_check_status", default: false
    t.index ["user_id"], name: "index_details_on_user_id"
  end

  create_table "expensegroups", force: :cascade do |t|
    t.integer "user_id"
    t.decimal "totalamount"
    t.decimal "approvedamount"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "group_status", default: 0
    t.integer "status", default: 0
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.string "department"
    t.decimal "phoneno"
    t.string "gender"
    t.boolean "admin"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.string "status"
    t.string "empid"
  end

end
