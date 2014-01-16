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

ActiveRecord::Schema.define(version: 20140116192546) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "connections", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "headline"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "linkedin_id"
    t.json     "profile"
    t.datetime "last_crawled"
  end

  create_table "connections_users", id: false, force: true do |t|
    t.integer "connection_id"
    t.integer "user_id"
  end

  create_table "pools", force: true do |t|
    t.string   "name"
    t.string   "invite_key"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "invite_url"
  end

  add_index "pools", ["owner_id"], name: "index_pools_on_owner_id", using: :btree

  create_table "pools_users", id: false, force: true do |t|
    t.integer "pool_id"
    t.integer "user_id"
  end

  add_index "pools_users", ["pool_id"], name: "index_pools_users_on_pool_id", using: :btree
  add_index "pools_users", ["user_id"], name: "index_pools_users_on_user_id", using: :btree

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
    t.datetime "last_crawled"
  end

end
