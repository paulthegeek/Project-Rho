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

ActiveRecord::Schema.define(version: 20140603021031) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comic_series", force: true do |t|
    t.string  "name"
    t.integer "sub_id"
  end

  create_table "comics", force: true do |t|
    t.string   "title"
    t.decimal  "price"
    t.integer  "image_id"
    t.integer  "comic_series_id"
    t.integer  "publisher_id"
    t.date     "release_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "variant"
    t.boolean  "reprint"
  end

  create_table "comics_creators", id: false, force: true do |t|
    t.integer "comic_id"
    t.integer "creator_id"
  end

  create_table "creators", force: true do |t|
    t.string "name"
    t.string "role"
  end

  create_table "publishers", force: true do |t|
    t.string "name"
  end

  add_index "publishers", ["name"], name: "index_publishers_on_name", unique: true, using: :btree

end
