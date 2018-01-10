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

ActiveRecord::Schema.define(version: 20180110081455) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "kelimeads", force: :cascade do |t|
    t.string "ad", null: false
    t.index ["ad"], name: "kelimeads_ad_uindex", unique: true
  end

  create_table "kelimes", force: :cascade do |t|
    t.bigint "kelimead_id"
    t.index ["kelimead_id"], name: "index_kelimes_on_kelimead_id"
  end

  create_table "kelimeturs", force: :cascade do |t|
    t.bigint "kelime_id"
    t.bigint "tur_id"
    t.index ["kelime_id"], name: "index_kelimeturs_on_kelime_id"
    t.index ["tur_id"], name: "index_kelimeturs_on_tur_id"
  end

  create_table "okelimes", force: :cascade do |t|
    t.string "ad", null: false
    t.bigint "tehdit"
    t.bigint "kufur"
    t.bigint "aldatma"
    t.bigint "siddet"
    t.bigint "kayitsayisi"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "turs", force: :cascade do |t|
    t.boolean "tehdit", null: false
    t.boolean "kufur", null: false
    t.boolean "aldatma", null: false
    t.boolean "siddet", null: false
  end

  create_table "tweetonays", force: :cascade do |t|
    t.bigint "tweet_id"
    t.string "icerik"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tweet_id"], name: "index_tweetonays_on_tweet_id"
  end

  create_table "tweets", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "tweetid", null: false
    t.integer "tehdit", limit: 2
    t.integer "kufur", limit: 2
    t.integer "aldatma", limit: 2
    t.integer "siddet", limit: 2
    t.index ["user_id"], name: "index_tweets_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "provider"
    t.string "uid"
    t.string "name"
    t.string "token"
    t.string "secret"
    t.string "profile_image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "yoneticis", id: false, force: :cascade do |t|
    t.bigint "user_id"
    t.index ["user_id"], name: "index_yoneticis_on_user_id"
  end

  add_foreign_key "kelimes", "kelimeads"
  add_foreign_key "kelimeturs", "kelimes"
  add_foreign_key "kelimeturs", "turs"
  add_foreign_key "tweetonays", "tweets"
  add_foreign_key "tweets", "users"
  add_foreign_key "yoneticis", "users"
end
