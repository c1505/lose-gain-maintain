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

ActiveRecord::Schema.define(version: 20171017170145) do

  create_table "competitions", force: :cascade do |t|
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_competitions_on_user_id"
  end

  create_table "competitions_users", id: false, force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "competition_id", null: false
    t.index ["user_id", "competition_id"], name: "index_competitions_users_on_user_id_and_competition_id"
  end

  create_table "fats", force: :cascade do |t|
    t.float "skinfold"
    t.float "percentage"
    t.integer "user_id"
    t.datetime "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_fats_on_user_id"
  end

  create_table "goals", force: :cascade do |t|
    t.float "weight"
    t.datetime "start_date"
    t.datetime "target_date"
    t.float "tolerence_above"
    t.float "tolerence_below"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_goals_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "weights", force: :cascade do |t|
    t.float "pounds"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "date"
    t.integer "user_id"
    t.index ["user_id"], name: "index_weights_on_user_id"
  end

end
