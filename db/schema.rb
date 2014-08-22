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

ActiveRecord::Schema.define(version: 20140822032538) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "birds", force: true do |t|
    t.integer "code"
  end

  create_table "critters", force: true do |t|
    t.string   "name"
    t.string   "latin_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type"
    t.text     "description"
  end

  create_table "explorers", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "explorers", ["email"], name: "index_explorers_on_email", unique: true, using: :btree
  add_index "explorers", ["reset_password_token"], name: "index_explorers_on_reset_password_token", unique: true, using: :btree

  create_table "guide_items", force: true do |t|
    t.integer  "section_id"
    t.integer  "critter_id"
    t.integer  "secion_index"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "guides", force: true do |t|
    t.string   "name"
    t.integer  "explorer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "identifying_images", force: true do |t|
    t.integer  "critter_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image"
    t.string   "attribution"
  end

  create_table "plants", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "re_tweets", force: true do |t|
    t.integer  "tweet_id",     limit: 8
    t.string   "tweeter"
    t.string   "tweet_text"
    t.string   "retweet_text"
    t.boolean  "did_retweet"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "tweet_as"
    t.integer  "popularity"
  end

  create_table "sections", force: true do |t|
    t.string   "name"
    t.integer  "guide_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "section_number"
  end

end
