# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2025_05_12_075153) do
  create_table "facilitator_topics", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "topic_id", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["topic_id"], name: "index_facilitator_topics_on_topic_id"
    t.index ["user_id", "topic_id"], name: "index_facilitator_topics_on_user_id_and_topic_id", unique: true
    t.index ["user_id"], name: "index_facilitator_topics_on_user_id"
  end

  create_table "group_members", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "group_id", null: false
    t.integer "status", default: 0, null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["group_id"], name: "index_group_members_on_group_id"
    t.index ["user_id", "group_id"], name: "index_group_members_on_user_id_and_group_id", unique: true
    t.index ["user_id"], name: "index_group_members_on_user_id"
  end

  create_table "group_session_participants", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "group_session_id", null: false
    t.integer "status", default: 0, null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["group_session_id", "status"], name: "idx_on_group_session_id_status_5e6ca411cd"
    t.index ["group_session_id"], name: "index_group_session_participants_on_group_session_id"
    t.index ["user_id", "group_session_id"], name: "idx_on_user_id_group_session_id_78c0339fcb", unique: true
    t.index ["user_id"], name: "index_group_session_participants_on_user_id"
  end

  create_table "group_sessions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "group_id", null: false
    t.datetime "starts_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id", "starts_at"], name: "index_group_sessions_on_group_id_and_starts_at"
    t.index ["group_id"], name: "index_group_sessions_on_group_id"
  end

  create_table "groups", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "description", null: false
    t.integer "duration", default: 60, null: false
    t.bigint "facilitator_id", null: false
    t.integer "frequency", default: 0, null: false
    t.integer "max_participants", default: 10, null: false
    t.integer "min_participants", default: 2, null: false
    t.string "subtitle"
    t.string "title", null: false
    t.integer "topic_id", null: false
    t.datetime "updated_at", null: false
    t.string "uuid", null: false
    t.index ["facilitator_id"], name: "index_groups_on_facilitator_id"
    t.index ["topic_id"], name: "index_groups_on_topic_id"
    t.index ["uuid"], name: "index_groups_on_uuid", unique: true
  end

  create_table "topics", force: :cascade do |t|
    t.integer "category", default: 0, null: false
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.datetime "updated_at", null: false
    t.index ["category"], name: "index_topics_on_category"
    t.index ["name"], name: "index_topics_on_name", unique: true
  end

  create_table "user_profiles", force: :cascade do |t|
    t.text "bio"
    t.datetime "created_at", null: false
    t.string "firstname", null: false
    t.string "job"
    t.string "lastname", null: false
    t.string "short_bio"
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_user_profiles_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "confirmation_sent_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "created_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.integer "role", default: 0, null: false
    t.string "unconfirmed_email"
    t.datetime "updated_at", null: false
    t.string "username", null: false
    t.string "uuid", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username"
    t.index ["uuid"], name: "index_users_on_uuid", unique: true
  end

  add_foreign_key "facilitator_topics", "topics"
  add_foreign_key "facilitator_topics", "users"
  add_foreign_key "group_members", "groups"
  add_foreign_key "group_members", "users"
  add_foreign_key "group_session_participants", "group_sessions"
  add_foreign_key "group_session_participants", "users"
  add_foreign_key "group_sessions", "groups"
  add_foreign_key "groups", "topics"
  add_foreign_key "user_profiles", "users"
end
