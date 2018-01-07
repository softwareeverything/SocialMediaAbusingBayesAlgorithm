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

ActiveRecord::Schema.define(version: 20180106135234) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "kelimeads", force: :cascade do |t|
    t.string "ad", null: false
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

  create_table "turs", force: :cascade do |t|
    t.boolean "tehdit", null: false
    t.boolean "kufur", null: false
    t.boolean "aldatma", null: false
    t.boolean "siddet", null: false
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

  add_foreign_key "kelimes", "kelimeads"
  add_foreign_key "kelimeturs", "kelimes"
  add_foreign_key "kelimeturs", "turs"
end
