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

ActiveRecord::Schema.define(:version => 20120927011921) do

  create_table "animals", :force => true do |t|
    t.string   "animal_type"
    t.string   "name"
    t.string   "breed"
    t.integer  "weight"
    t.string   "farm"
    t.string   "host"
    t.string   "photo"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "cuts", :force => true do |t|
    t.string   "name"
    t.float    "price"
    t.float    "percent"
    t.float    "package_weight"
    t.integer  "line_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "animal_type"
  end

  add_index "cuts", ["line_id"], :name => "index_cuts_on_line_id"

  create_table "lines", :force => true do |t|
    t.integer  "units"
    t.string   "notes"
    t.integer  "order_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "cut_id"
  end

  create_table "orders", :force => true do |t|
    t.integer  "status"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "animal_id"
  end

  add_index "orders", ["user_id"], :name => "index_orders_on_user_id"

  create_table "packages", :force => true do |t|
    t.integer  "cut_id"
    t.integer  "original"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "animal_id"
    t.integer  "left"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "password_digest"
    t.string   "remember_token"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
