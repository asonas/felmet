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

ActiveRecord::Schema.define(version: 20150506152026) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", force: :cascade do |t|
    t.integer  "user_id",     null: false
    t.integer  "felica_id",   null: false
    t.datetime "checkin_at"
    t.datetime "checkout_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "location_id", null: false
  end

  add_index "events", ["felica_id"], name: "index_events_on_felica_id", using: :btree
  add_index "events", ["location_id"], name: "index_events_on_location_id", using: :btree
  add_index "events", ["user_id"], name: "index_events_on_user_id", using: :btree

  create_table "felicas", force: :cascade do |t|
    t.string   "idm",                          null: false
    t.boolean  "activation",   default: false, null: false
    t.datetime "activated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "felicas", ["activation"], name: "index_felicas_on_activation", using: :btree
  add_index "felicas", ["idm"], name: "index_felicas_on_idm", unique: true, using: :btree

  create_table "groups", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "locations", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", force: :cascade do |t|
    t.string   "template_name"
    t.string   "title"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.integer  "felica_id"
    t.integer  "group_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
    t.string   "other_email"
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["group_id"], name: "index_users_on_group_id", using: :btree
  add_index "users", ["other_email"], name: "index_users_on_other_email", using: :btree

end
