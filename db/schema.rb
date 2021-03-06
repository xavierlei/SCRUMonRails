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

ActiveRecord::Schema.define(version: 20160511091405) do

  create_table "projects", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "projects", ["user_id", "created_at"], name: "index_projects_on_user_id_and_created_at"
  add_index "projects", ["user_id"], name: "index_projects_on_user_id"

  create_table "requirements", force: :cascade do |t|
    t.text     "description"
    t.integer  "project_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "requirements", ["project_id"], name: "index_requirements_on_project_id"

  create_table "roles", force: :cascade do |t|
    t.string   "description"
    t.integer  "user_id"
    t.integer  "team_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "email"
  end

  add_index "roles", ["email"], name: "index_roles_on_email"
  add_index "roles", ["team_id"], name: "index_roles_on_team_id"
  add_index "roles", ["user_id"], name: "index_roles_on_user_id"

  create_table "sprints", force: :cascade do |t|
    t.date     "begin_date"
    t.date     "end_date"
    t.integer  "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "sprints", ["project_id"], name: "index_sprints_on_project_id"

  create_table "tasks", force: :cascade do |t|
    t.integer  "team_id"
    t.integer  "sprint_id"
    t.integer  "requirement_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "tasks", ["requirement_id"], name: "index_tasks_on_requirement_id"
  add_index "tasks", ["sprint_id"], name: "index_tasks_on_sprint_id"
  add_index "tasks", ["team_id"], name: "index_tasks_on_team_id"

  create_table "teams", force: :cascade do |t|
    t.string   "name"
    t.integer  "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "teams", ["project_id"], name: "index_teams_on_project_id"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "password_digest"
    t.string   "remember_digest"
    t.boolean  "admin",           default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

end
