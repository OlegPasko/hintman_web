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

ActiveRecord::Schema.define(version: 20141213182500) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "groups", force: true do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hints", force: true do |t|
    t.text     "content"
    t.integer  "group_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "hints", ["group_id"], name: "index_hints_on_group_id", using: :btree
  add_index "hints", ["user_id"], name: "index_hints_on_user_id", using: :btree

  create_table "user_votes", force: true do |t|
    t.integer  "user_id"
    t.integer  "hint_id"
    t.boolean  "positive"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "user_votes", ["hint_id"], name: "index_user_votes_on_hint_id", using: :btree
  add_index "user_votes", ["user_id"], name: "index_user_votes_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email"
    t.integer  "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "device_id"
    t.string   "auth_token"
  end

  add_index "users", ["group_id"], name: "index_users_on_group_id", using: :btree

  add_foreign_key "hints", "groups"
  add_foreign_key "hints", "users"
  add_foreign_key "user_votes", "hints"
  add_foreign_key "user_votes", "users"
  add_foreign_key "users", "groups"
end
