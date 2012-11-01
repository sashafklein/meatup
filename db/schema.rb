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

ActiveRecord::Schema.define(:version => 20121101204844) do

  create_table "animals", :force => true do |t|
    t.string   "animal_type"
    t.string   "name"
    t.string   "breed"
    t.integer  "weight"
    t.string   "photo"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.integer  "ranch_id"
    t.integer  "butcher_id"
    t.float    "cow_mult"
    t.float    "pig_mult"
    t.float    "lamb_mult"
    t.float    "goat_mult"
    t.integer  "host_id"
    t.boolean  "final_sale",   :default => false
    t.boolean  "opening_sale", :default => false
    t.boolean  "open",         :default => true
    t.boolean  "finalized",    :default => false
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
    t.string   "state"
    t.string   "zip"
    t.string   "city"
  end

  create_table "cuts", :force => true do |t|
    t.string   "name"
    t.float    "price"
    t.float    "percent"
    t.float    "package_weight"
    t.integer  "line_id"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.string   "animal_type"
    t.float    "comp"
    t.integer  "savings"
    t.boolean  "incentive",      :default => false
    t.text     "description"
  end

  add_index "cuts", ["line_id"], :name => "index_cuts_on_line_id"

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "hosts", :force => true do |t|
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "phone"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "zip"
    t.integer  "user_id"
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
    t.float    "total"
  end

  add_index "orders", ["user_id"], :name => "index_orders_on_user_id"

  create_table "packages", :force => true do |t|
    t.integer  "cut_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "animal_id"
    t.float    "price"
    t.integer  "line_id"
    t.boolean  "sold"
    t.integer  "savings"
    t.float    "true_weight"
  end

  create_table "ranches", :force => true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "phone"
    t.integer  "user_id"
    t.boolean  "cow",               :default => false
    t.boolean  "pig",               :default => false
    t.boolean  "lamb",              :default => false
    t.boolean  "goat",              :default => false
    t.float    "cow_live"
    t.float    "pig_live"
    t.float    "goat_live"
    t.float    "lamb_live"
    t.float    "cow_meat"
    t.float    "pig_meat"
    t.float    "lamb_meat"
    t.float    "goat_meat"
    t.float    "cow_hanging"
    t.float    "pig_hanging"
    t.float    "lamb_hanging"
    t.float    "goat_hanging"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.string   "state"
    t.string   "zip"
    t.string   "city"
    t.integer  "preferred_butcher"
    t.boolean  "has_csa",           :default => false
    t.boolean  "delivers_butcher",  :default => false
    t.boolean  "delivers_drop",     :default => false
    t.boolean  "delivers_host",     :default => false
    t.integer  "cow_fixed",         :default => 0
    t.integer  "pig_fixed",         :default => 0
    t.integer  "lamb_fixed",        :default => 0
    t.integer  "goat_fixed",        :default => 0
    t.string   "description"
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
    t.boolean  "is_host",         :default => false
    t.boolean  "is_rancher",      :default => false
    t.boolean  "is_butcher",      :default => false
    t.integer  "butcher_id"
    t.integer  "ranch_id"
    t.integer  "host_id"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
