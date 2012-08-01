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

ActiveRecord::Schema.define(:version => 20120801193650) do

  create_table "orders", :force => true do |t|
    t.string   "street_address"
    t.string   "state"
    t.string   "city"
    t.string   "country"
    t.integer  "zipcode"
    t.integer  "customer_id"
    t.integer  "price"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "paypal_transactions", :force => true do |t|
    t.string   "address_city"
    t.string   "address_country"
    t.string   "address_country_code"
    t.string   "address_street"
    t.string   "address_state"
    t.integer  "address_zip"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "payer_email"
    t.string   "payer_id"
    t.string   "contact_phone"
    t.string   "residence_country"
    t.string   "item_name"
    t.integer  "item_number"
    t.integer  "quantity"
    t.string   "custom"
    t.string   "memo"
    t.string   "txn_id"
    t.string   "txn_type"
    t.string   "payment_status"
    t.string   "payment_type"
    t.decimal  "payment_fee",          :precision => 8, :scale => 2
    t.decimal  "payment_gross",        :precision => 8, :scale => 2
    t.datetime "payment_date"
    t.string   "mc_currency"
    t.decimal  "mc_fee",               :precision => 8, :scale => 2
    t.decimal  "mc_gross",             :precision => 8, :scale => 2
    t.decimal  "tax",                  :precision => 8, :scale => 2
    t.decimal  "shipping",             :precision => 8, :scale => 2
    t.string   "verify_sign"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "gamecenter_id"
    t.string   "facebook_id"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
