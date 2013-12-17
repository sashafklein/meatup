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

ActiveRecord::Schema.define(:version => 20131217170321) do

  create_table "animals", :force => true do |t|
    t.string   "animal_type"
    t.string   "name"
    t.string   "breed"
    t.integer  "live_weight"
    t.string   "photo"
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
    t.integer  "ranch_id"
    t.integer  "butcher_id"
    t.integer  "host_id"
    t.boolean  "open",                 :default => true
    t.boolean  "finalized",            :default => false
    t.float    "hanging_weight"
    t.float    "meat_weight"
    t.boolean  "no_sales",             :default => false
    t.boolean  "conduct_opening_sale", :default => false
    t.boolean  "conduct_final_sale",   :default => false
    t.boolean  "on_opening_sale",      :default => false
    t.boolean  "on_final_sale",        :default => false
    t.float    "price_multiplier",     :default => 1.0
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
    t.integer  "location_id"
  end

  add_index "butchers", ["location_id"], :name => "index_butchers_on_location_id"

  create_table "cuts", :force => true do |t|
    t.string   "name"
    t.float    "price"
    t.float    "percent"
    t.float    "package_weight"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.string   "animal_type"
    t.float    "comp"
    t.integer  "savings"
    t.boolean  "incentive",      :default => false
    t.text     "description"
    t.string   "prep_options"
  end

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
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "zip"
    t.integer  "user_id"
    t.integer  "location_id"
  end

  add_index "hosts", ["location_id"], :name => "index_hosts_on_location_id"

  create_table "lines", :force => true do |t|
    t.integer  "units"
    t.string   "notes",       :default => ""
    t.integer  "order_id"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
    t.integer  "real_cut_id"
    t.integer  "sale_price"
  end

  add_index "lines", ["real_cut_id"], :name => "index_lines_on_real_cut_id"

  create_table "locations", :force => true do |t|
    t.string   "zip"
    t.string   "street_address"
    t.string   "phone_number"
    t.string   "state"
    t.string   "city"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "orders", :force => true do |t|
    t.integer  "status"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "animal_id"
    t.float    "total"
    t.float    "difference"
  end

  add_index "orders", ["user_id"], :name => "index_orders_on_user_id"

  create_table "packages", :force => true do |t|
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.float    "price"
    t.integer  "line_id"
    t.integer  "savings"
    t.float    "true_weight"
    t.boolean  "sold",        :default => false
    t.integer  "animal_id"
    t.integer  "cut_id"
    t.integer  "real_cut_id"
  end

  add_index "packages", ["real_cut_id"], :name => "index_packages_on_real_cut_id"

  create_table "ranch_animals", :force => true do |t|
    t.string   "animal_type"
    t.float    "meat_price"
    t.float    "hanging_price"
    t.float    "live_price"
    t.float    "fixed_cost",    :default => 0.0
    t.integer  "ranch_id"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  create_table "ranches", :force => true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "phone"
    t.integer  "user_id"
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
    t.string   "description"
    t.integer  "location_id"
  end

  add_index "ranches", ["location_id"], :name => "index_ranches_on_location_id"

  create_table "real_cuts", :force => true do |t|
    t.integer  "animal_id"
    t.integer  "cut_id"
    t.integer  "flat_price"
    t.float    "weight"
    t.integer  "expected_units"
    t.integer  "sold_units",     :default => 0
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  add_index "real_cuts", ["animal_id"], :name => "index_real_cuts_on_animal_id"
  add_index "real_cuts", ["cut_id"], :name => "index_real_cuts_on_cut_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",           :default => false
    t.string   "zip"
    t.boolean  "is_host",         :default => false
    t.boolean  "is_rancher",      :default => false
    t.boolean  "is_butcher",      :default => false
    t.integer  "butcher_id"
    t.integer  "ranch_id"
    t.integer  "host_id"
    t.boolean  "beta",            :default => true
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
