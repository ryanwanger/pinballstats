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

ActiveRecord::Schema.define(version: 20150517212019) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "games", force: true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_path"
  end

  create_table "group_players", force: true do |t|
    t.integer  "group_id"
    t.integer  "player_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "group_players", ["group_id"], name: "index_group_players_on_group_id", using: :btree
  add_index "group_players", ["player_id"], name: "index_group_players_on_player_id", using: :btree

  create_table "groups", force: true do |t|
    t.integer  "league_night_id"
    t.integer  "group_rank"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "league_games", force: true do |t|
    t.integer  "game_id"
    t.integer  "league_night_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "league_nights", force: true do |t|
    t.date     "date"
    t.integer  "league_id"
    t.integer  "location_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "week_number"
  end

  create_table "leagues", force: true do |t|
    t.date     "start_date"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "locations", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "matchups", force: true do |t|
    t.integer  "league_night_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "players", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "nickname"
  end

  create_table "scores", force: true do |t|
    t.integer  "score",                limit: 8
    t.integer  "player_id"
    t.integer  "league_game_id"
    t.integer  "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "points"
    t.integer  "outscored_percentage"
    t.boolean  "team_win",                       default: false
  end

  create_table "team_players", force: true do |t|
    t.integer  "team_id"
    t.integer  "player_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teams", force: true do |t|
    t.integer  "league_night_id"
    t.integer  "matchup_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
