# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_02_27_053528) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "exercises", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "category"
    t.index ["user_id"], name: "index_exercises_on_user_id"
  end

  create_table "measures", force: :cascade do |t|
    t.bigint "user_id"
    t.float "body_weight"
    t.float "calorie"
    t.float "neck"
    t.float "shoulder"
    t.float "chest"
    t.float "left_biceps"
    t.float "right_biceps"
    t.float "left_forearm"
    t.float "right_forearm"
    t.float "upper_abdomen"
    t.float "lower_abdomen"
    t.float "waist"
    t.float "hips"
    t.float "left_thigh"
    t.float "right_thigh"
    t.float "left_calf"
    t.float "right_calf"
    t.date "date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "body_fat"
    t.index ["user_id"], name: "index_measures_on_user_id"
  end

  create_table "relationship_requests", force: :cascade do |t|
    t.bigint "requester_id"
    t.bigint "recipient_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["recipient_id"], name: "index_relationship_requests_on_recipient_id"
    t.index ["requester_id", "recipient_id"], name: "index_relationship_requests_on_requester_id_and_recipient_id", unique: true
    t.index ["requester_id"], name: "index_relationship_requests_on_requester_id"
  end

  create_table "relationships", force: :cascade do |t|
    t.bigint "follower_id"
    t.bigint "followed_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["followed_id"], name: "index_relationships_on_followed_id"
    t.index ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true
    t.index ["follower_id"], name: "index_relationships_on_follower_id"
  end

  create_table "routine_exercises", force: :cascade do |t|
    t.bigint "routine_id"
    t.bigint "exercise_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["exercise_id"], name: "index_routine_exercises_on_exercise_id"
    t.index ["routine_id"], name: "index_routine_exercises_on_routine_id"
  end

  create_table "routines", force: :cascade do |t|
    t.bigint "user_id"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_routines_on_user_id"
  end

  create_table "scores", force: :cascade do |t|
    t.float "weight"
    t.integer "repetitions"
    t.integer "interval_time"
    t.float "rpe"
    t.bigint "user_id"
    t.bigint "exercise_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.date "date"
    t.index ["exercise_id"], name: "index_scores_on_exercise_id"
    t.index ["user_id"], name: "index_scores_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.string "token"
    t.boolean "user_private", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["name"], name: "index_users_on_name", unique: true
  end

  add_foreign_key "exercises", "users"
  add_foreign_key "measures", "users"
  add_foreign_key "relationship_requests", "users", column: "recipient_id"
  add_foreign_key "relationship_requests", "users", column: "requester_id"
  add_foreign_key "relationships", "users", column: "followed_id"
  add_foreign_key "relationships", "users", column: "follower_id"
  add_foreign_key "routine_exercises", "exercises"
  add_foreign_key "routine_exercises", "routines"
  add_foreign_key "routines", "users"
  add_foreign_key "scores", "exercises"
  add_foreign_key "scores", "users"
end
