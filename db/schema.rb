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

ActiveRecord::Schema.define(version: 20170331152844) do

  create_table "character_scenes", force: :cascade do |t|
    t.integer  "character_id"
    t.integer  "scene_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["character_id"], name: "index_character_scenes_on_character_id"
    t.index ["scene_id"], name: "index_character_scenes_on_scene_id"
  end

  create_table "characters", force: :cascade do |t|
    t.string   "name"
    t.integer  "person_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["person_id"], name: "index_characters_on_person_id"
  end

  create_table "check_ins", force: :cascade do |t|
    t.integer  "person_id"
    t.integer  "rehearsal_id"
    t.datetime "checked_in_at"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["person_id"], name: "index_check_ins_on_person_id"
    t.index ["rehearsal_id"], name: "index_check_ins_on_rehearsal_id"
  end

  create_table "conflicts", force: :cascade do |t|
    t.datetime "start"
    t.datetime "end"
    t.integer  "person_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "type"
    t.string   "frequency"
    t.index ["person_id"], name: "index_conflicts_on_person_id"
  end

  create_table "crew_calls", force: :cascade do |t|
    t.integer  "crew_role_id"
    t.integer  "rehearsal_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["crew_role_id"], name: "index_crew_calls_on_crew_role_id"
    t.index ["rehearsal_id"], name: "index_crew_calls_on_rehearsal_id"
  end

  create_table "crew_roles", force: :cascade do |t|
    t.integer  "person_id"
    t.string   "title"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "department_id"
    t.index ["department_id"], name: "index_crew_roles_on_department_id"
    t.index ["person_id"], name: "index_crew_roles_on_person_id"
  end

  create_table "department_notes", force: :cascade do |t|
    t.integer  "department_id"
    t.integer  "note_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["department_id"], name: "index_department_notes_on_department_id"
    t.index ["note_id"], name: "index_department_notes_on_note_id"
  end

  create_table "departments", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notes", force: :cascade do |t|
    t.integer  "rehearsal_id"
    t.text     "content"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["rehearsal_id"], name: "index_notes_on_rehearsal_id"
  end

  create_table "people", force: :cascade do |t|
    t.string   "first"
    t.string   "last"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "production_id"
    t.string   "ios_uuid"
    t.string   "cell"
    t.string   "email"
    t.index ["production_id"], name: "index_people_on_production_id"
  end

  create_table "person_works", force: :cascade do |t|
    t.integer  "person_id"
    t.integer  "work_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["person_id"], name: "index_person_works_on_person_id"
    t.index ["work_id"], name: "index_person_works_on_work_id"
  end

  create_table "productions", force: :cascade do |t|
    t.string   "title"
    t.date     "first_rehearsal"
    t.date     "last_rehearsal"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "ios_code"
    t.datetime "ios_expiration"
  end

  create_table "rehearsal_scenes", force: :cascade do |t|
    t.integer  "rehearsal_id"
    t.integer  "scene_id"
    t.datetime "expected_start"
    t.datetime "expected_end"
    t.datetime "actual_start"
    t.datetime "actual_end"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["rehearsal_id"], name: "index_rehearsal_scenes_on_rehearsal_id"
    t.index ["scene_id"], name: "index_rehearsal_scenes_on_scene_id"
  end

  create_table "rehearsals", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "scenes", force: :cascade do |t|
    t.string   "number"
    t.integer  "production_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["production_id"], name: "index_scenes_on_production_id"
  end

  create_table "schedules", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "person_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["person_id"], name: "index_users_on_person_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "works", force: :cascade do |t|
    t.string   "name"
    t.string   "work_type"
    t.integer  "duration"
    t.integer  "break_duration"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "rehearsal_id"
    t.integer  "production_id"
    t.index ["production_id"], name: "index_works_on_production_id"
    t.index ["rehearsal_id"], name: "index_works_on_rehearsal_id"
  end

end
