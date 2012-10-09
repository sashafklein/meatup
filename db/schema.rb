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

ActiveRecord::Schema.define(:version => 20121009072843) do

  create_table "animals", :force => true do |t|
    t.string   "animal_type"
    t.string   "name"
    t.string   "breed"
    t.integer  "weight"
    t.string   "host"
    t.string   "photo"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "ranch_id"
    t.integer  "butcher_id"
    t.decimal  "cow_mult"
    t.decimal  "pig_mult"
    t.decimal  "lamb_mult"
    t.decimal  "goat_mult"
  end

  create_table "butchers", :force => true do |t|
    t.string   "name"
    t.string   "address"
    t.decimal  "hanging_price"
    t.decimal  "final_price"
    t.decimal  "vacuum_price"
    t.decimal  "wrap_price"
    t.string   "phone"
    t.integer  "user_id"
    t.boolean  "ground"
    t.boolean  "stew"
    t.boolean  "boneless"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
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
    t.float    "comp"
    t.integer  "savings"
  end

  add_index "cuts", ["line_id"], :name => "index_cuts_on_line_id"

  create_table "hosts", :force => true do |t|
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "phone"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

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
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "animal_id"
    t.decimal  "price"
    t.integer  "line_id"
    t.boolean  "sold"
    t.integer  "savings"
  end

  create_table "ranches", :force => true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "phone"
    t.integer  "user_id"
    t.boolean  "cow"
    t.boolean  "pig"
    t.boolean  "lamb"
    t.boolean  "goat"
    t.decimal  "cow_live"
    t.decimal  "pig_live"
    t.decimal  "goat_live"
    t.decimal  "lamb_live"
    t.decimal  "cow_meat"
    t.decimal  "pig_meat"
    t.decimal  "lamb_meat"
    t.decimal  "goat_meat"
    t.decimal  "cow_hanging"
    t.decimal  "pig_hanging"
    t.decimal  "lamb_hanging"
    t.decimal  "goat_hanging"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",           :default => false
    t.string   "zip"
    t.boolean  "apology"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
