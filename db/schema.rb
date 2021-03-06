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

ActiveRecord::Schema.define(version: 20160714213447) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ad_images", force: true do |t|
    t.integer  "link_id"
    t.string   "image_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ad_images", ["link_id"], name: "index_ad_images_on_link_id", using: :btree

  create_table "client_users", force: true do |t|
    t.integer  "client_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "client_users", ["client_id"], name: "index_client_users_on_client_id", using: :btree
  add_index "client_users", ["user_id"], name: "index_client_users_on_user_id", using: :btree

  create_table "clients", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "created_by"
  end

  create_table "links", force: true do |t|
    t.text     "link_reference"
    t.string   "communication_id"
    t.string   "campaign_medium"
    t.string   "campaign_source"
    t.string   "campaign_name"
    t.string   "utm_content"
    t.string   "short_link"
    t.string   "website_url"
    t.integer  "client_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "utm_link"
    t.integer  "user_id"
    t.string   "created_by"
  end

  add_index "links", ["client_id"], name: "index_links_on_client_id", using: :btree

  create_table "user_adders", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "client"
    t.string   "user_email"
  end

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
  end

end
