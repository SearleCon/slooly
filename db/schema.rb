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

ActiveRecord::Schema.define(version: 20160329133454) do

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
    t.string   "headline",    limit: 255
    t.text     "description"
    t.string   "posted_by",   limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "clients", force: :cascade do |t|
    t.string   "business_name",  limit: 255
    t.string   "contact_person", limit: 255
    t.string   "address",        limit: 255
    t.string   "city",           limit: 255
    t.string   "post_code",      limit: 255
    t.string   "telephone",      limit: 255
    t.string   "fax",            limit: 255
    t.string   "email",          limit: 255
    t.integer  "user_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "clients", ["user_id"], name: "index_clients_on_user_id", using: :btree

  create_table "companies", force: :cascade do |t|
    t.string   "name",       limit: 255, default: "Your Company Name"
    t.string   "address",    limit: 255, default: "44 Street Name, Suburb"
    t.string   "city",       limit: 255, default: "Best City"
    t.string   "post_code",  limit: 255, default: "1234"
    t.string   "telephone",  limit: 255, default: "555 345 6789"
    t.string   "fax",        limit: 255, default: "People still fax?"
    t.string   "email",      limit: 255, default: "you@example.com"
    t.integer  "user_id"
    t.datetime "created_at",                                                null: false
    t.datetime "updated_at",                                                null: false
  end

  add_index "companies", ["user_id"], name: "index_companies_on_user_id", using: :btree

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",               default: 0
    t.integer  "attempts",               default: 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by",  limit: 255
    t.string   "queue",      limit: 255
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree
  add_index "delayed_jobs", ["queue"], name: "index_delayed_jobs_on_queue", using: :btree

  create_table "histories", force: :cascade do |t|
    t.date     "date_sent"
    t.integer  "client_id"
    t.string   "subject",           limit: 255
    t.text     "message"
    t.string   "reminder_type",     limit: 255
    t.boolean  "sent",                          default: false
    t.string   "email_return_code", limit: 255, default: "Not yet sent"
    t.string   "email_sent_from",   limit: 255
    t.string   "copy_email",        limit: 255
    t.string   "email_sent_to",     limit: 255
    t.datetime "created_at",                                             null: false
    t.datetime "updated_at",                                             null: false
    t.string   "invoice_number",    limit: 255
    t.string   "email_from_name",   limit: 255
    t.integer  "invoice_id"
  end

  add_index "histories", ["client_id"], name: "index_histories_on_client_id", using: :btree
  add_index "histories", ["invoice_id"], name: "index_histories_on_invoice_id", using: :btree

  create_table "invoices", force: :cascade do |t|
    t.string   "invoice_number", limit: 255
    t.date     "due_date"
    t.decimal  "amount"
    t.text     "description"
    t.integer  "status",                     default: 2
    t.integer  "client_id"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.integer  "user_id"
    t.date     "pd_date"
    t.date     "od1_date"
    t.date     "od2_date"
    t.date     "od3_date"
    t.date     "last_date_sent"
    t.date     "fd_date"
  end

  add_index "invoices", ["client_id"], name: "index_invoices_on_client_id", using: :btree
  add_index "invoices", ["status"], name: "index_invoices_on_status", using: :btree
  add_index "invoices", ["user_id"], name: "index_invoices_on_user_id", using: :btree

  create_table "plans", force: :cascade do |t|
    t.string   "description", limit: 255
    t.integer  "duration"
    t.decimal  "cost"
    t.boolean  "active"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.boolean  "free"
  end

  create_table "settings", force: :cascade do |t|
    t.string   "reminder_email_sender_name",            limit: 255, default: "Your Business"
    t.string   "reminder_email_cc_address",             limit: 255, default: "copy@example.com"
    t.integer  "chasing_interval",                                  default: 7
    t.integer  "pre_due_interval",                                  default: 2
    t.text     "payment_method_message",                            default: "(Deposit or Transfer to:\nBank:\nAccount:\nAccount Type:\nBranch Code:)"
    t.boolean  "send_pre_due_reminder_email",                       default: true
    t.string   "pre_due_reminder_email_subject",        limit: 255, default: "Friendly Reminder: Payment due soon"
    t.text     "pre_due_reminder_email_message",                    default: "This is a friendly reminder that payment for the above invoice is due in a couple of days time.\nWe really do appreciate your timely payment.\n\nPayment can be made by any of the methods listed below.\n\nWe appreciate your support and value you as our customer.\n\nKind regards,"
    t.boolean  "send_due_reminder_email",                           default: true
    t.string   "due_reminder_email_subject",            limit: 255, default: "Payment Due Today"
    t.text     "due_reminder_email_message",                        default: "This is a friendly reminder that payment for the above invoice is due today.\nWe really do appreciate your timely payment.\n\nPayment can be made by any of the methods listed below.\nIf you have already paid, please ignore this email.\n\nWe appreciate your support.\n\nKind regards,"
    t.string   "first_overdue_reminder_email_subject",  limit: 255, default: "Important Reminder: Payment overdue"
    t.text     "first_overdue_reminder_email_message",              default: "Please note that payment for the above invoice is now overdue.\nWe really do appreciate your business and timeous payment.\n\nPayment can be made by any of the methods listed below.\nIf you have already paid, please email or fax proof of payment to us (our contact details above).\n\nWe appreciate your support.\n\nKind regards,"
    t.string   "second_overdue_reminder_email_subject", limit: 255, default: "Second Reminder - Important: Payment is overdue"
    t.text     "second_overdue_reminder_email_message",             default: "Payment for the above invoice is now overdue.\nPlease make the payment as soon as possible.\n\nPayment can be made by any of the methods listed below.\nIf you have already paid, please email or fax proof of payment to us (our contact details above).\n\nThank you.\n\nKind regards,"
    t.string   "third_overdue_reminder_email_subject",  limit: 255, default: "URGENT: Third and Final Reminder: Payment is now way overdue!"
    t.text     "third_overdue_reminder_email_message",              default: "This is your third and final reminder. Payment for the above invoice is now very overdue!\nPlease make payment urgently.\n\nPayment can be made by any of the methods listed below.\nIf you have already paid, please email or fax proof of payment to us (our contact details above).\n\nIf you are not intending on paying, please give us a call or send us an email, so that we can make alternative arrangements if necessary.\n\nKind regards,"
    t.string   "final_demand_reminder_email_subject",   limit: 255, default: "Notice of Final Demand: Action Required"
    t.text     "final_demand_reminder_email_message",               default: "Please understand that this is our FINAL NOTICE regarding payment for the above invoice.\nPlease make payment immediately.\n\nIf we do not receive full payment within 3 days, we will have no alternative but to hand your account over to a collection agency (Interest and collection fees will also be added to your owing amount in this case).\n\nPayment can be made by any of the methods listed below.\nIf you have already paid, please email or fax proof of payment to us (our contact details above).\n\nIf you are not intending on paying, or are unable to pay due to unforeseen circumstances, please give us a call or send us an email, so that we can make alternative arrangements if necessary.\n\nKind regards,"
    t.integer  "user_id"
    t.datetime "created_at",                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           null: false
    t.datetime "updated_at",                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           null: false
  end

  add_index "settings", ["user_id"], name: "index_settings_on_user_id", using: :btree

  create_table "statuses", force: :cascade do |t|
    t.string   "description", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "subscriptions", force: :cascade do |t|
    t.integer  "plan_id"
    t.date     "expiry_date"
    t.boolean  "active",                                     default: true
    t.integer  "user_id"
    t.datetime "created_at",                                                null: false
    t.datetime "updated_at",                                                null: false
    t.string   "paypal_customer_token",          limit: 255
    t.string   "paypal_recurring_profile_token", limit: 255
  end

  add_index "subscriptions", ["plan_id"], name: "index_subscriptions_on_plan_id", using: :btree
  add_index "subscriptions", ["user_id"], name: "index_subscriptions_on_user_id", using: :btree

  create_table "suggestions", force: :cascade do |t|
    t.string   "subject",    limit: 255
    t.text     "comment"
    t.string   "email",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "name",                   limit: 255
    t.string   "time_zone"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "vouchers", force: :cascade do |t|
    t.string   "unique_code",    limit: 255
    t.integer  "redeemed_by"
    t.datetime "valid_until"
    t.integer  "number_of_days",             default: 30
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
  end

  add_foreign_key "clients", "users", on_delete: :cascade
  add_foreign_key "companies", "users", on_delete: :cascade
  add_foreign_key "histories", "clients", on_delete: :cascade
  add_foreign_key "histories", "invoices", on_delete: :cascade
  add_foreign_key "invoices", "clients", on_delete: :cascade
  add_foreign_key "settings", "users", on_delete: :cascade
  add_foreign_key "subscriptions", "plans", name: "subscriptions_plan_id_fk"
  add_foreign_key "subscriptions", "users", on_delete: :cascade
  add_foreign_key "vouchers", "users", column: "redeemed_by", on_delete: :cascade
end
