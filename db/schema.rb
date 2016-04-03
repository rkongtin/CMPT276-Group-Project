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

ActiveRecord::Schema.define(version: 20160403015116) do

  create_table "houses", force: :cascade do |t|
    t.string   "address"
    t.integer  "price"
    t.integer  "sqft"
    t.text     "amenities"
    t.integer  "contact_info"
    t.string   "pictures"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.string   "pictures_file_name"
    t.string   "pictures_content_type"
    t.integer  "pictures_file_size"
    t.datetime "pictures_updated_at"
    t.float    "lat"
    t.float    "long"
  end

  create_table "schools", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.decimal  "lat"
    t.decimal  "long"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.boolean  "admin",                 default: false
    t.string   "pictures_file_name"
    t.string   "pictures_content_type"
    t.integer  "pictures_file_size"
    t.datetime "pictures_updated_at"
    t.string   "pictures"
  end

end
