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

ActiveRecord::Schema.define(version: 20140319132407) do

  create_table "donations", force: true do |t|
    t.integer  "user_id"
    t.decimal  "amount",     precision: 15, scale: 2, default: 0.0
    t.string   "category"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fiscal_stats", force: true do |t|
    t.integer  "fiscal_year"
    t.string   "currency_type"
    t.decimal  "total_revenue",         precision: 15, scale: 2
    t.decimal  "net_profit",            precision: 15, scale: 2
    t.decimal  "available_social_fund", precision: 15, scale: 2
    t.integer  "user_id"
    t.boolean  "eligibility_status",                             default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "pref_cat"
  end

  create_table "issues", force: true do |t|
    t.integer  "user_id"
    t.string   "issue_description"
    t.string   "issue_area"
    t.integer  "issue_area_code",   limit: 8
    t.string   "issue_status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "project_est_cost",            precision: 15, scale: 2, default: 0.0
    t.boolean  "is_approved",                                          default: false
    t.string   "issue_title"
    t.integer  "closed_by"
    t.integer  "rejected_by"
    t.date     "rejected_on"
    t.date     "closed_on"
    t.string   "category"
  end

  create_table "issues_users", force: true do |t|
    t.integer  "user_id"
    t.integer  "issue_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "logos", force: true do |t|
    t.integer  "user_id"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
  end

  create_table "project_fund_logs", force: true do |t|
    t.integer  "project_id"
    t.integer  "user_id"
    t.decimal  "fund_amount", precision: 15, scale: 2, default: 0.0
    t.string   "transc_type"
    t.string   "category"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "project_funds", force: true do |t|
    t.integer  "project_id"
    t.integer  "project_report_id"
    t.string   "fund_status",                                default: "pending"
    t.integer  "allocate_by"
    t.decimal  "fund_amount",       precision: 15, scale: 2, default: 0.0
    t.date     "allocate_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "project_report_logs", force: true do |t|
    t.integer  "project_id"
    t.integer  "user_id"
    t.string   "action"
    t.string   "desc"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "project_report_id"
  end

  create_table "project_reports", force: true do |t|
    t.integer  "project_id"
    t.integer  "percent_done"
    t.integer  "user_id"
    t.string   "status",       default: "pending"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remarks"
    t.boolean  "fund_release", default: false
  end

  create_table "projects", force: true do |t|
    t.string   "project_name"
    t.string   "project_type"
    t.string   "area"
    t.decimal  "project_est_cost",       precision: 15, scale: 2, default: 0.0
    t.decimal  "project_actual_cost",    precision: 15, scale: 2, default: 0.0
    t.date     "est_start_date"
    t.date     "actual_start_date"
    t.date     "est_completion_date"
    t.date     "actual_completion_date"
    t.integer  "assigned_to"
    t.integer  "assigned_by"
    t.integer  "verified_by"
    t.integer  "closed_by"
    t.string   "project_duration"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "verified",                                        default: false
    t.string   "project_status"
    t.integer  "user_id"
    t.integer  "proposer_id"
    t.integer  "issue_id"
    t.date     "closed_on"
    t.date     "approved_on"
  end

  create_table "proposals", force: true do |t|
    t.decimal  "proposed_cost",     precision: 15, scale: 2
    t.integer  "proposed_duration"
    t.integer  "user_id"
    t.integer  "issue_id"
    t.string   "desc"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status"
  end

  create_table "social_funds", force: true do |t|
    t.integer  "fiscal_year"
    t.decimal  "total_kitty_fund",     precision: 15, scale: 2, default: 0.0
    t.decimal  "fund_used",            precision: 15, scale: 2, default: 0.0
    t.decimal  "fund_remains",         precision: 15, scale: 2, default: 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "fund_for_children",    precision: 15, scale: 2, default: 0.0
    t.decimal  "fund_for_disabled",    precision: 15, scale: 2, default: 0.0
    t.decimal  "fund_for_education",   precision: 15, scale: 2, default: 0.0
    t.decimal  "fund_for_elderly",     precision: 15, scale: 2, default: 0.0
    t.decimal  "fund_for_employment",  precision: 15, scale: 2, default: 0.0
    t.decimal  "fund_for_environment", precision: 15, scale: 2, default: 0.0
    t.decimal  "fund_for_health",      precision: 15, scale: 2, default: 0.0
    t.decimal  "fund_for_women",       precision: 15, scale: 2, default: 0.0
    t.decimal  "fund_for_youth",       precision: 15, scale: 2, default: 0.0
    t.decimal  "fund_for_others",      precision: 15, scale: 2, default: 0.0
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
    t.string   "website_address"
    t.text     "about"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
