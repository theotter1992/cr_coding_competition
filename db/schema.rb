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

ActiveRecord::Schema.define(version: 20170228104401) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "email_recipients", force: :cascade do |t|
    t.integer  "email_id"
    t.integer  "recipient_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "email_recipients", ["email_id"], name: "index_email_recipients_on_email_id", using: :btree
  add_index "email_recipients", ["recipient_id"], name: "index_email_recipients_on_recipient_id", using: :btree

  create_table "emails", force: :cascade do |t|
    t.datetime "timestamp"
    t.string   "subject",   array: true
  end

  add_index "emails", ["timestamp"], name: "index_emails_on_timestamp", using: :btree

  create_table "recipients", force: :cascade do |t|
    t.string  "email"
    t.integer "counter_unique_subject_words", default: 0
  end

  add_index "recipients", ["email"], name: "index_recipients_on_email", unique: true, using: :btree

  add_foreign_key "email_recipients", "emails"
  add_foreign_key "email_recipients", "recipients"
end
