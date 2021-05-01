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

ActiveRecord::Schema.define(version: 2021_05_01_225118) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "albums", id: false, force: :cascade do |t|
    t.string "id"
    t.string "artist_id"
    t.string "name"
    t.string "genre"
    t.string "artist"
    t.string "tracks"
    t.string "self"
  end

  create_table "artists", id: false, force: :cascade do |t|
    t.string "id"
    t.string "name"
    t.integer "age"
    t.string "albums"
    t.string "tracks"
    t.string "self"
  end

  create_table "tracks", id: false, force: :cascade do |t|
    t.string "id"
    t.string "album_id"
    t.string "name"
    t.float "duration"
    t.integer "times_played"
    t.string "artist"
    t.string "album"
    t.string "self"
  end

end
