# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100322040946) do

  create_table "event_types", :force => true do |t|
    t.string   "name"
    t.integer  "icon_id"
    t.integer  "icon_type_id"
    t.text     "parse_method"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", :force => true do |t|
    t.integer  "user_id"
    t.integer  "event_type_id"
    t.string   "twitter_status_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "icon_types", :force => true do |t|
    t.string   "name"
    t.string   "picture"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "icons", :force => true do |t|
    t.string   "name"
    t.string   "picture"
    t.string   "url"
    t.integer  "icon_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "item_types", :force => true do |t|
    t.string   "name"
    t.integer  "icon_id"
    t.integer  "price"
    t.text     "action_method"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "items", :force => true do |t|
    t.integer  "user_id"
    t.integer  "item_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "patterns", :force => true do |t|
    t.string   "regex"
    t.integer  "event_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "typus_users", :force => true do |t|
    t.string   "first_name",       :default => "",    :null => false
    t.string   "last_name",        :default => "",    :null => false
    t.string   "role",                                :null => false
    t.string   "email",                               :null => false
    t.boolean  "status",           :default => false
    t.string   "token",                               :null => false
    t.string   "salt",                                :null => false
    t.string   "crypted_password",                    :null => false
    t.string   "preferences"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "twitter_id"
    t.string   "twitter_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
