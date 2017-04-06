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

ActiveRecord::Schema.define(version: 20170405213532) do

  create_table "organizations", force: :cascade do |t|
    t.string   "login"
    t.integer  "gh_id"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pulls", force: :cascade do |t|
    t.integer  "gh_id"
    t.integer  "repo_gh_id"
    t.string   "state"
    t.integer  "gh_number"
    t.string   "title"
    t.text     "body"
    t.datetime "gh_created_at"
    t.datetime "gh_updated_at"
    t.datetime "gh_closed_at"
    t.datetime "gh_merged_at"
    t.string   "merge_commit_sha"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.datetime "first_commit_at"
  end

  create_table "repos", force: :cascade do |t|
    t.integer  "gh_id"
    t.string   "name"
    t.integer  "organization_gh_id"
    t.string   "description"
    t.datetime "gh_created_at"
    t.datetime "gh_updated_at"
    t.datetime "gh_pushed_at"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

end
