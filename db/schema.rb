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

ActiveRecord::Schema.define(:version => 20130301200506) do

  create_table "developers", :force => true do |t|
    t.string   "merchant_name"
    t.string   "api_key"
    t.integer  "user_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "developers", ["user_id"], :name => "index_developers_on_user_id"

  create_table "items", :force => true do |t|
    t.string   "name"
    t.string   "desc"
    t.string   "options"
    t.string   "display_text"
    t.decimal  "price"
    t.string   "sku"
    t.integer  "developer_id"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.integer  "item_type"
  end

  add_index "items", ["developer_id"], :name => "index_items_on_user_id"

  create_table "transactions", :force => true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "email"
    t.string   "token"
    t.decimal  "subtotal",          :precision => 8, :scale => 2
    t.decimal  "shipping",          :precision => 8, :scale => 2
    t.decimal  "total",             :precision => 8, :scale => 2
    t.string   "pp_transaction_id"
    t.string   "lj_transaction_id"
    t.datetime "created_at",                                      :null => false
    t.datetime "updated_at",                                      :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "role"
    t.string   "name"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
