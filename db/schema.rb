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

ActiveRecord::Schema.define(version: 20150407163338) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "movies", force: :cascade do |t|
    t.text     "genres",                                array: true
    t.string   "title"
    t.text     "overview"
    t.string   "poster_path"
    t.integer  "runtime"
    t.string   "tagline"
    t.string   "tmdb_vote_average"
    t.integer  "guidebox_id"
    t.string   "artwork"
    t.integer  "rottentomatoes_id"
    t.string   "imdb_id"
    t.integer  "themoviedb_id"
    t.string   "trailer"
    t.text     "cast",                                  array: true
    t.text     "purchase_web_sources",                  array: true
    t.text     "free_web_sources",                      array: true
    t.text     "subscription_web_sources",              array: true
    t.text     "other_sources",                         array: true
    t.text     "rt_ratings"
    t.text     "rt_reviews",                            array: true
    t.text     "related",                               array: true
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "thumbnail"
  end

  create_table "playlists", force: :cascade do |t|
    t.integer "user_id"
    t.string  "name"
    t.integer "list_type"
  end

  add_index "playlists", ["user_id"], name: "index_playlists_on_user_id", using: :btree

  create_table "saved_movies", force: :cascade do |t|
    t.integer "playlist_id"
    t.integer "movie_id"
  end

  add_index "saved_movies", ["movie_id"], name: "index_saved_movies_on_movie_id", using: :btree
  add_index "saved_movies", ["playlist_id"], name: "index_saved_movies_on_playlist_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "first_name",      null: false
    t.string   "last_name",       null: false
    t.string   "email"
    t.string   "username"
    t.string   "password_digest"
    t.string   "token"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_foreign_key "playlists", "users"
  add_foreign_key "saved_movies", "movies"
  add_foreign_key "saved_movies", "playlists"
end
