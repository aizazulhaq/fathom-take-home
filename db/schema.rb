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

ActiveRecord::Schema[7.2].define(version: 2024_10_27_110442) do
  create_table "meeting_recordings", force: :cascade do |t|
    t.string "title", null: false
    t.string "thumbnail_url", null: false
    t.string "recording_page_url", null: false
    t.integer "creator_user_id", null: false
    t.integer "creator_role_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["creator_role_id"], name: "index_meeting_recordings_on_creator_role_id"
    t.index ["creator_user_id"], name: "index_meeting_recordings_on_creator_user_id"
  end

  create_table "role_access_policies", force: :cascade do |t|
    t.integer "creator_role_id", null: false
    t.integer "viewer_role_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["creator_role_id", "viewer_role_id"], name: "index_role_access_policies_on_creator_and_viewer", unique: true
    t.index ["creator_role_id"], name: "index_role_access_policies_on_creator_role_id"
    t.index ["viewer_role_id"], name: "index_role_access_policies_on_viewer_role_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "role_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["role_name"], name: "index_roles_on_role_name", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "username", null: false
    t.string "email", null: false
    t.string "encrypted_password", default: "", null: false
    t.integer "role_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["role_id"], name: "index_users_on_role_id"
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "meeting_recordings", "roles", column: "creator_role_id"
  add_foreign_key "meeting_recordings", "users", column: "creator_user_id"
  add_foreign_key "role_access_policies", "roles", column: "creator_role_id"
  add_foreign_key "role_access_policies", "roles", column: "viewer_role_id"
  add_foreign_key "users", "roles"
end
