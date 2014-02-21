# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20140221055750) do

  create_table "fiscal_stats", force: true do |t|
    t.integer  "fiscal_year"
    t.decimal  "opening_blnc",          precision: 15, scale: 2
    t.decimal  "closing_blnc",          precision: 15, scale: 2
    t.string   "currency_type"
    t.decimal  "total_revenue",         precision: 15, scale: 2
    t.decimal  "net_profit",            precision: 15, scale: 2
    t.decimal  "available_social_fund", precision: 15, scale: 2
    t.integer  "user_id"
    t.boolean  "eligibility_status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                             default: "", null: false
    t.string   "encrypted_password",                default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                     default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "address"
    t.integer  "pin_code",               limit: 8
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.string   "mobile_number"
    t.string   "phone_number"
    t.string   "fax_number"
    t.string   "owner"
    t.string   "service_type"
    t.string   "company_group"
    t.string   "pan_number"
    t.string   "tan_number"
    t.integer  "year_established"
    t.integer  "no_of_employees"
    t.integer  "age",                    limit: 3
    t.string   "gender",                 limit: 6
    t.string   "adhaar_number"
    t.string   "voter_id"
    t.string   "nationality"
    t.string   "role",                   limit: 15
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
