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

ActiveRecord::Schema.define(version: 20170410062547) do

  create_table "id_pics", force: :cascade do |t|
    t.string   "pic_name"
    t.string   "url"
    t.string   "path"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "invoice_pics", force: :cascade do |t|
    t.string   "url"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orderlists", force: :cascade do |t|
    t.string   "good_serial_num"
    t.string   "good_no"
    t.string   "good_name"
    t.string   "good_type"
    t.string   "product_country"
    t.string   "trade_currency"
    t.float    "declare_price"
    t.float    "declare_total"
    t.float    "declare_num"
    t.string   "declare_unit"
    t.float    "goods_weight"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "orders", force: :cascade do |t|
    t.string   "trans_no"
    t.string   "waybill"
    t.string   "local_port"
    t.datetime "in_out_time"
    t.string   "ship_port"
    t.string   "conveyance_name"
    t.string   "conveyance_code"
    t.string   "conveyance_type"
    t.string   "declarer_name"
    t.string   "declarer_phone"
    t.string   "declarer_addr"
    t.string   "declarer_id"
    t.string   "declare_company_code"
    t.string   "declare_company_name"
    t.string   "trade_country"
    t.integer  "package_count"
    t.integer  "package_type"
    t.string   "declare_port"
    t.string   "shipper_name"
    t.string   "shipper_country"
    t.string   "shipper_city"
    t.string   "currency"
    t.string   "declare_type"
    t.string   "main_good"
    t.string   "real_name"
    t.string   "real_addr"
    t.string   "real_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "patch_id"
    t.integer  "good_serial_num"
    t.string   "good_no"
    t.string   "good_name"
    t.string   "good_type"
    t.float    "declare_price"
    t.float    "declare_total"
    t.float    "declare_num"
    t.string   "declare_unit"
    t.float    "goods_weight"
    t.string   "real_waybill"
    t.string   "real_transformer"
    t.string   "consigneeProv"
    t.string   "consigneeCity"
    t.string   "consigneeTown"
    t.string   "markDest"
    t.string   "sortingSite"
    t.string   "sortingCode"
    t.string   "pkgCode"
    t.string   "realName"
    t.string   "realPhone"
    t.string   "consigneeAdress"
    t.string   "id_pic"
    t.string   "inv_pic"
  end

  create_table "patches", force: :cascade do |t|
    t.string   "patch_no"
    t.integer  "orders_count"
    t.string   "trans_no"
    t.float    "total_weight"
    t.integer  "package_count"
    t.float    "goods_count"
    t.datetime "import_time"
    t.datetime "print_cus_time"
    t.datetime "print_cus2_time"
    t.datetime "print_ciq_time"
    t.datetime "print_ciq2_time"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
