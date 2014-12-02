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

ActiveRecord::Schema.define(version: 20141202125952) do

  create_table "announcements", force: true do |t|
    t.string    "headline"
    t.text      "description"
    t.string    "posted_by"
    t.timestamp "created_at",  null: false
    t.timestamp "updated_at",  null: false
  end

  create_table "clients", force: true do |t|
    t.string    "business_name"
    t.string    "contact_person"
    t.string    "address"
    t.string    "city"
    t.string    "post_code"
    t.string    "telephone"
    t.string    "fax"
    t.string    "email"
    t.integer   "user_id"
    t.timestamp "created_at",     null: false
    t.timestamp "updated_at",     null: false
  end

  add_index "clients", ["user_id"], name: "index_clients_on_user_id"

  create_table "companies", force: true do |t|
    t.string    "name"
    t.string    "logo_path"
    t.string    "address"
    t.string    "city"
    t.string    "post_code"
    t.string    "telephone"
    t.string    "fax"
    t.string    "email"
    t.integer   "user_id"
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
    t.string    "image"
  end

  add_index "companies", ["user_id"], name: "index_companies_on_user_id"

  create_table "delayed_jobs", force: true do |t|
    t.integer   "priority",   default: 0
    t.integer   "attempts",   default: 0
    t.text      "handler"
    t.text      "last_error"
    t.timestamp "run_at"
    t.timestamp "locked_at"
    t.timestamp "failed_at"
    t.string    "locked_by"
    t.string    "queue"
    t.timestamp "created_at",             null: false
    t.timestamp "updated_at",             null: false
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority"

  create_table "histories", force: true do |t|
    t.date      "date_sent"
    t.integer   "client_id"
    t.integer   "user_id"
    t.string    "subject"
    t.text      "message"
    t.string    "reminder_type"
    t.boolean   "sent"
    t.string    "email_return_code"
    t.string    "email_sent_from"
    t.string    "copy_email"
    t.string    "email_sent_to"
    t.timestamp "created_at",        null: false
    t.timestamp "updated_at",        null: false
    t.string    "invoice_number"
    t.string    "email_from_name"
  end

  add_index "histories", ["client_id"], name: "index_histories_on_client_id"
  add_index "histories", ["user_id"], name: "index_histories_on_user_id"

  create_table "invoices", force: true do |t|
    t.string    "invoice_number"
    t.date      "due_date"
    t.decimal   "amount"
    t.text      "description"
    t.integer   "status_id"
    t.integer   "client_id"
    t.timestamp "created_at",     null: false
    t.timestamp "updated_at",     null: false
    t.integer   "user_id"
    t.date      "pd_date"
    t.date      "od1_date"
    t.date      "od2_date"
    t.date      "od3_date"
    t.date      "last_date_sent"
    t.date      "fd_date"
  end

  add_index "invoices", ["client_id"], name: "index_invoices_on_client_id"
  add_index "invoices", ["status_id"], name: "index_invoices_on_status_id"
  add_index "invoices", ["user_id"], name: "index_invoices_on_user_id"

  create_table "payment_notifications", force: true do |t|
    t.text      "params"
    t.integer   "user_id"
    t.string    "status"
    t.string    "transaction_id"
    t.timestamp "created_at",     null: false
    t.timestamp "updated_at",     null: false
  end

  add_index "payment_notifications", ["user_id"], name: "index_payment_notifications_on_user_id"

  create_table "plans", force: true do |t|
    t.string    "description"
    t.integer   "duration"
    t.decimal   "cost"
    t.boolean   "active"
    t.timestamp "created_at",  null: false
    t.timestamp "updated_at",  null: false
    t.boolean   "free"
  end

  create_table "settings", force: true do |t|
    t.string    "send_from_name"
    t.string    "email_copy_to"
    t.integer   "days_between_chase"
    t.integer   "days_before_pre_due"
    t.text      "payment_method_message"
    t.boolean   "pre_due_reminder"
    t.string    "pre_due_subject"
    t.text      "pre_due_message"
    t.boolean   "due_reminder"
    t.string    "due_subject"
    t.text      "due_message"
    t.string    "overdue1_subject"
    t.text      "overdue1_message"
    t.string    "overdue2_subject"
    t.text      "overdue2_message"
    t.string    "overdue3_subject"
    t.text      "overdue3_message"
    t.string    "final_demand_subject"
    t.text      "final_demand_message"
    t.integer   "user_id"
    t.timestamp "created_at",             null: false
    t.timestamp "updated_at",             null: false
  end

  add_index "settings", ["user_id"], name: "index_settings_on_user_id"

  create_table "statuses", force: true do |t|
    t.string    "description"
    t.timestamp "created_at",  null: false
    t.timestamp "updated_at",  null: false
  end

  create_table "subscriptions", force: true do |t|
    t.timestamp "bought_on"
    t.integer   "plan_id"
    t.date      "expiry_date"
    t.string    "time"
    t.boolean   "active"
    t.string    "paypal_id"
    t.integer   "user_id"
    t.timestamp "created_at",                     null: false
    t.timestamp "updated_at",                     null: false
    t.string    "paypal_customer_token"
    t.string    "paypal_recurring_profile_token"
  end

  add_index "subscriptions", ["plan_id"], name: "index_subscriptions_on_plan_id"
  add_index "subscriptions", ["user_id"], name: "index_subscriptions_on_user_id"

  create_table "suggestions", force: true do |t|
    t.string    "subject"
    t.text      "comment"
    t.string    "email"
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
  end

  create_table "users", force: true do |t|
    t.string    "email",                  default: "", null: false
    t.string    "encrypted_password",     default: "", null: false
    t.string    "reset_password_token"
    t.timestamp "reset_password_sent_at"
    t.timestamp "remember_created_at"
    t.integer   "sign_in_count",          default: 0
    t.timestamp "current_sign_in_at"
    t.timestamp "last_sign_in_at"
    t.string    "current_sign_in_ip"
    t.string    "last_sign_in_ip"
    t.timestamp "created_at",                          null: false
    t.timestamp "updated_at",                          null: false
    t.string    "name"
    t.integer   "role",                   default: 0
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "vouchers", force: true do |t|
    t.string    "unique_code"
    t.integer   "redeemed_by"
    t.timestamp "valid_until"
    t.integer   "number_of_days"
    t.timestamp "created_at",     null: false
    t.timestamp "updated_at",     null: false
  end

end
