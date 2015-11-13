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

ActiveRecord::Schema.define(version: 20151112090304) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "pg_trgm"

  create_table "admins", force: :cascade do |t|
    t.string   "email",               default: "", null: false
    t.string   "encrypted_password",  default: "", null: false
    t.datetime "remember_created_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree

  create_table "announcements", force: :cascade do |t|
    t.string   "headline"
    t.text     "description"
    t.string   "posted_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "clients", force: :cascade do |t|
    t.string   "business_name"
    t.string   "contact_person"
    t.string   "address"
    t.string   "city"
    t.string   "post_code"
    t.string   "telephone"
    t.string   "fax"
    t.string   "email"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "clients", ["business_name"], name: "business_name_idx", using: :gist
  add_index "clients", ["contact_person"], name: "contact_person_idx", using: :gist
  add_index "clients", ["user_id"], name: "index_clients_on_user_id", using: :btree

  create_table "companies", force: :cascade do |t|
    t.string   "name"
    t.string   "logo_path"
    t.string   "address"
    t.string   "city"
    t.string   "post_code"
    t.string   "telephone"
    t.string   "fax"
    t.string   "email"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image"
  end

  add_index "companies", ["user_id"], name: "index_companies_on_user_id", using: :btree

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0
    t.integer  "attempts",   default: 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree
  add_index "delayed_jobs", ["queue"], name: "index_delayed_jobs_on_queue", using: :btree

  create_table "histories", force: :cascade do |t|
    t.date     "date_sent"
    t.integer  "client_id"
    t.string   "subject"
    t.text     "message"
    t.string   "reminder_type"
    t.boolean  "sent"
    t.string   "email_return_code"
    t.string   "email_sent_from"
    t.string   "copy_email"
    t.string   "email_sent_to"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "invoice_number"
    t.string   "email_from_name"
  end

  add_index "histories", ["client_id"], name: "index_histories_on_client_id", using: :btree

  create_table "invoices", force: :cascade do |t|
    t.string   "invoice_number"
    t.date     "due_date"
    t.decimal  "amount"
    t.text     "description"
    t.integer  "status"
    t.integer  "client_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.date     "pd_date"
    t.date     "od1_date"
    t.date     "od2_date"
    t.date     "od3_date"
    t.date     "last_date_sent"
    t.date     "fd_date"
  end

  add_index "invoices", ["client_id"], name: "index_invoices_on_client_id", using: :btree
  add_index "invoices", ["description"], name: "description_idx", using: :gist
  add_index "invoices", ["invoice_number"], name: "invoice_number_idx", using: :gist
  add_index "invoices", ["status"], name: "index_invoices_on_status", using: :btree
  add_index "invoices", ["user_id"], name: "index_invoices_on_user_id", using: :btree

  create_table "plans", force: :cascade do |t|
    t.string   "description"
    t.integer  "duration"
    t.decimal  "cost"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "free"
  end

  create_table "settings", force: :cascade do |t|
    t.string   "send_from_name"
    t.string   "email_copy_to"
    t.integer  "days_between_chase"
    t.integer  "days_before_pre_due"
    t.text     "payment_method_message"
    t.boolean  "pre_due_reminder"
    t.string   "pre_due_subject"
    t.text     "pre_due_message"
    t.boolean  "due_reminder"
    t.string   "due_subject"
    t.text     "due_message"
    t.string   "overdue1_subject"
    t.text     "overdue1_message"
    t.string   "overdue2_subject"
    t.text     "overdue2_message"
    t.string   "overdue3_subject"
    t.text     "overdue3_message"
    t.string   "final_demand_subject"
    t.text     "final_demand_message"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "settings", ["user_id"], name: "index_settings_on_user_id", using: :btree

  create_table "statuses", force: :cascade do |t|
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.integer  "plan_id"
    t.date     "expiry_date"
    t.boolean  "active"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "paypal_customer_token"
    t.string   "paypal_recurring_profile_token"
  end

  add_index "subscriptions", ["plan_id"], name: "index_subscriptions_on_plan_id", using: :btree
  add_index "subscriptions", ["user_id"], name: "index_subscriptions_on_user_id", using: :btree

  create_table "suggestions", force: :cascade do |t|
    t.string   "subject"
    t.text     "comment"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "time_zone"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "vouchers", force: :cascade do |t|
    t.string   "unique_code"
    t.integer  "redeemed_by"
    t.datetime "valid_until"
    t.integer  "number_of_days"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_foreign_key "clients", "users", on_delete: :cascade
  add_foreign_key "companies", "users", on_delete: :cascade
  add_foreign_key "histories", "clients", on_delete: :cascade
  add_foreign_key "invoices", "clients", on_delete: :cascade
  add_foreign_key "settings", "users", on_delete: :cascade
  add_foreign_key "subscriptions", "plans", name: "subscriptions_plan_id_fk"
  add_foreign_key "subscriptions", "users", on_delete: :cascade
  add_foreign_key "vouchers", "users", column: "redeemed_by", on_delete: :cascade
end
