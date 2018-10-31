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

ActiveRecord::Schema.define(version: 2018_10_21_154246) do

  create_table "accounts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "email"
    t.string "password"
    t.string "fullname"
    t.string "address"
    t.string "phone"
    t.integer "account_type", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.index ["email"], name: "index_accounts_on_email", unique: true
  end

  create_table "categories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "content"
    t.bigint "account_id"
    t.bigint "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id", "created_at"], name: "index_comments_on_account_id_and_created_at"
    t.index ["account_id"], name: "index_comments_on_account_id"
    t.index ["product_id", "created_at"], name: "index_comments_on_product_id_and_created_at"
    t.index ["product_id"], name: "index_comments_on_product_id"
  end

  create_table "images", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "image_link"
    t.bigint "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id", "created_at"], name: "index_images_on_product_id_and_created_at"
    t.index ["product_id"], name: "index_images_on_product_id"
  end

  create_table "manufacturers", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "order_details", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "quantity"
    t.float "price"
    t.float "total_price"
    t.bigint "order_id"
    t.bigint "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id", "created_at"], name: "index_order_details_on_order_id_and_created_at"
    t.index ["order_id"], name: "index_order_details_on_order_id"
    t.index ["product_id", "created_at"], name: "index_order_details_on_product_id_and_created_at"
    t.index ["product_id"], name: "index_order_details_on_product_id"
  end

  create_table "orders", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "status"
    t.string "phone"
    t.string "address"
    t.float "total"
    t.bigint "account_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id", "created_at"], name: "index_orders_on_account_id_and_created_at"
    t.index ["account_id"], name: "index_orders_on_account_id"
  end

  create_table "products", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.integer "quantity"
    t.decimal "price", precision: 10
    t.text "description"
    t.integer "hot"
    t.bigint "category_id"
    t.bigint "manufacturer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id", "created_at"], name: "index_products_on_category_id_and_created_at"
    t.index ["category_id"], name: "index_products_on_category_id"
    t.index ["manufacturer_id", "created_at"], name: "index_products_on_manufacturer_id_and_created_at"
    t.index ["manufacturer_id"], name: "index_products_on_manufacturer_id"
  end

  add_foreign_key "comments", "accounts"
  add_foreign_key "comments", "products"
  add_foreign_key "images", "products"
  add_foreign_key "order_details", "orders"
  add_foreign_key "order_details", "products"
  add_foreign_key "orders", "accounts"
  add_foreign_key "products", "categories"
  add_foreign_key "products", "manufacturers"
end
