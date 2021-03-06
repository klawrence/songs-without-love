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

ActiveRecord::Schema.define(version: 20140511050411) do

  create_table "artists", force: true do |t|
    t.string   "name"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "artists", ["name"], name: "index_artists_on_name", using: :btree
  add_index "artists", ["slug"], name: "index_artists_on_slug", unique: true, using: :btree

  create_table "friendly_id_slugs", force: true do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "songs", force: true do |t|
    t.integer  "artist_id"
    t.string   "title"
    t.string   "slug"
    t.text     "lyrics"
    t.integer  "peak_chart_position"
    t.string   "weeks_on_chart"
    t.date     "first_charted_on"
    t.boolean  "reissue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "songs", ["artist_id"], name: "index_songs_on_artist_id", using: :btree
  add_index "songs", ["first_charted_on"], name: "index_songs_on_first_charted_on", using: :btree
  add_index "songs", ["slug"], name: "index_songs_on_slug", unique: true, using: :btree
  add_index "songs", ["title"], name: "index_songs_on_title", using: :btree

end
