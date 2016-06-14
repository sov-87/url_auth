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

ActiveRecord::Schema.define(version: 20160510193823) do

  create_table "url_auth_groups", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "url_auth_groups", ["name"], name: "index_url_auth_groups_on_name", unique: true

  create_table "url_auth_groups_urls", force: true do |t|
    t.integer "group_id"
    t.integer "url_id"
  end

  add_index "url_auth_groups_urls", ["url_id", "group_id"], name: "index_url_auth_groups_urls_on_url_id_and_group_id", unique: true

  create_table "url_auth_groups_users", force: true do |t|
    t.integer "user_id"
    t.integer "group_id"
  end

  add_index "url_auth_groups_users", ["user_id", "group_id"], name: "index_url_auth_groups_users_on_user_id_and_group_id", unique: true

  create_table "url_auth_urls", force: true do |t|
    t.string   "url_pattern"
    t.string   "name"
    t.string   "http_method"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "url_auth_users", force: true do |t|
    t.string   "name"
    t.string   "api_code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "url_auth_users", ["name"], name: "index_url_auth_users_on_name", unique: true

end
