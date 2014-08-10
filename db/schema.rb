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

ActiveRecord::Schema.define(version: 20140810185319) do

  create_table "events", force: true do |t|
    t.integer  "user_id",     null: false
    t.integer  "felica_id",   null: false
    t.datetime "checkin_at"
    t.datetime "checkout_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "location_id", null: false
  end

  add_index "events", ["felica_id"], name: "index_events_on_felica_id"
  add_index "events", ["location_id"], name: "index_events_on_location_id"
  add_index "events", ["user_id"], name: "index_events_on_user_id"

  create_table "felicas", force: true do |t|
    t.string   "idm",                          null: false
    t.boolean  "activation",   default: false, null: false
    t.datetime "activated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "felicas", ["activation"], name: "index_felicas_on_activation"
  add_index "felicas", ["idm"], name: "index_felicas_on_idm", unique: true

  create_table "groups", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "locations", force: true do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.integer  "felica_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
