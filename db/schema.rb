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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120223214121) do

  create_table "game_prisoners", :force => true do |t|
    t.integer  "prisoner_id", :null => false
    t.integer  "game_id",     :null => false
    t.boolean  "confess"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "game_prisoners", ["game_id", "prisoner_id"], :name => "index_game_prisoners_on_game_id_and_prisoner_id", :unique => true

  create_table "games", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "prisoners", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password"
    t.string   "salt"
  end

end
