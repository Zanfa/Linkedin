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

ActiveRecord::Schema.define(version: 20140115170953) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "aggregators", force: true do |t|
    t.string   "name"
    t.string   "invite_key"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "users",      array: true
    t.string   "invite_url"
  end

  add_index "aggregators", ["owner_id"], name: "index_aggregators_on_owner_id", using: :btree

  create_table "connections", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "headline"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "linkedin_id"
    t.json     "profile"
  end

  create_table "positions", force: true do |t|
    t.string   "title"
    t.string   "organization"
    t.integer  "connection_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "positions", ["connection_id"], name: "index_positions_on_connection_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "linkedin_id"
    t.string   "linkedin_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "linkedin_secret"
  end

end
