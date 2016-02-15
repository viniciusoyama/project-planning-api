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

ActiveRecord::Schema.define(version: 20160215012232) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clients", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "people", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "job_title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "projects", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "client_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "projects", ["client_id"], name: "index_projects_on_client_id", using: :btree

  create_table "tasks", force: :cascade do |t|
    t.string   "name"
    t.integer  "client_id"
    t.integer  "project_id"
    t.text     "notes"
    t.date     "start_at"
    t.date     "end_at"
    t.integer  "effort_per_day_in_hours", default: 8
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "tasks", ["client_id"], name: "index_tasks_on_client_id", using: :btree
  add_index "tasks", ["project_id"], name: "index_tasks_on_project_id", using: :btree

  add_foreign_key "projects", "clients"
  add_foreign_key "tasks", "clients"
  add_foreign_key "tasks", "projects"
end
