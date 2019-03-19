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

ActiveRecord::Schema.define(version: 2019_03_19_140736) do

  create_table "case_results", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "case_id"
    t.text "result_array"
    t.text "path_array"
    t.string "case_name"
    t.string "case_tag"
    t.string "case_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cases", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "username"
    t.string "name"
    t.string "tag"
    t.string "time"
    t.text "desc"
    t.string "file"
    t.text "file_body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
