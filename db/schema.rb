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

ActiveRecord::Schema.define(version: 20160501114636) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "describers", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "describers", ["name"], name: "index_describers_on_name", unique: true, using: :btree

  create_table "genres", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "links", force: :cascade do |t|
    t.string   "imdb_id"
    t.integer  "tmdb_id"
    t.integer  "movie_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "links", ["movie_id"], name: "index_links_on_movie_id", using: :btree

  create_table "movie_describers", force: :cascade do |t|
    t.integer  "movie_id"
    t.integer  "describer_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "movie_describers", ["describer_id"], name: "index_movie_describers_on_describer_id", using: :btree
  add_index "movie_describers", ["movie_id"], name: "index_movie_describers_on_movie_id", using: :btree

  create_table "movie_genres", force: :cascade do |t|
    t.integer  "movie_id"
    t.integer  "genre_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "movie_genres", ["genre_id"], name: "index_movie_genres_on_genre_id", using: :btree
  add_index "movie_genres", ["movie_id"], name: "index_movie_genres_on_movie_id", using: :btree

  create_table "movies", force: :cascade do |t|
    t.string   "title"
    t.integer  "movielens_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "overview"
    t.string   "plot"
    t.string   "rate"
  end

  add_index "movies", ["movielens_id"], name: "index_movies_on_movielens_id", using: :btree
  add_index "movies", ["title"], name: "index_movies_on_title", using: :btree

  create_table "profiles", force: :cascade do |t|
    t.string   "full_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ratings", force: :cascade do |t|
    t.float    "score"
    t.integer  "movie_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "ratings", ["movie_id"], name: "index_ratings_on_movie_id", using: :btree
  add_index "ratings", ["user_id"], name: "index_ratings_on_user_id", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string   "tag"
    t.integer  "movie_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "tags", ["movie_id"], name: "index_tags_on_movie_id", using: :btree
  add_index "tags", ["user_id"], name: "index_tags_on_user_id", using: :btree

  create_table "user_ratings", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "rating_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "user_ratings", ["rating_id"], name: "index_user_ratings_on_rating_id", using: :btree
  add_index "user_ratings", ["user_id"], name: "index_user_ratings_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string   "access_token"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "profile_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["profile_id"], name: "index_users_on_profile_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "links", "movies"
  add_foreign_key "movie_describers", "describers"
  add_foreign_key "movie_describers", "movies"
  add_foreign_key "movie_genres", "genres"
  add_foreign_key "movie_genres", "movies"
  add_foreign_key "ratings", "movies"
  add_foreign_key "ratings", "users"
  add_foreign_key "tags", "movies"
  add_foreign_key "tags", "users"
  add_foreign_key "user_ratings", "ratings"
  add_foreign_key "user_ratings", "users"
  add_foreign_key "users", "profiles"
end
