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

ActiveRecord::Schema.define(version: 20170515084556) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "matches", force: :cascade do |t|
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "tournament_id"
    t.integer  "round_id"
    t.integer  "team1_id"
    t.integer  "team2_id"
    t.integer  "count_matches"
    t.integer  "team1_score",       default: 0
    t.integer  "team2_score",       default: 0
    t.integer  "team1_count_goals", default: 0
    t.integer  "team2_count_goals", default: 0
  end

  create_table "rounds", force: :cascade do |t|
    t.string   "name"
    t.string   "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teams", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "points_count"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "user1_id"
    t.integer  "user2_id"
    t.integer  "tournament_id"
  end

  create_table "teams_matches", force: :cascade do |t|
    t.integer  "team_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "match_id"
  end

  create_table "tournament_rounds", force: :cascade do |t|
    t.integer  "id_tournament"
    t.integer  "id_round"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "tournament_teams", force: :cascade do |t|
    t.integer  "id_team"
    t.integer  "id_tournament"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "tournament_types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tournaments", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "tournament_type_id"
  end

  create_table "user_ranks", force: :cascade do |t|
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "user_vote_id"
    t.integer  "tournament_id"
    t.integer  "user_id"
    t.integer  "rank"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "password_digest"
    t.string   "remember_token"
    t.string   "facebook_id"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.string   "provider"
    t.string   "image"
    t.boolean  "is_admin"
    t.integer  "rank"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["remember_token"], name: "index_users_on_remember_token", using: :btree
  end

  add_foreign_key "matches", "teams", column: "team1_id"
  add_foreign_key "matches", "teams", column: "team2_id"
  add_foreign_key "teams", "users", column: "user1_id"
  add_foreign_key "teams", "users", column: "user2_id"
end
