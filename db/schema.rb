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

ActiveRecord::Schema.define(version: 2018_10_21_095717) do

  create_table "account", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "email", limit: 191
    t.string "password", limit: 45
  end

  create_table "account_type", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "name", limit: 200, collation: "utf8_general_ci"
  end

  create_table "categories", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "name"
    t.string "string"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "category", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "name", limit: 45
  end

  create_table "comment", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "content", limit: 45
  end

  create_table "detail_export", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "quantity"
    t.float "price"
  end

  create_table "export_product", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "state"
    t.date "date_export"
    t.string "descrition", limit: 45
  end

  create_table "images", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "name"
    t.bigint "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id", "created_at"], name: "index_images_on_product_id_and_created_at"
    t.index ["product_id"], name: "index_images_on_product_id"
  end

  create_table "manufacturers", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "product", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "name", limit: 200, collation: "utf8_general_ci"
    t.string "contry", limit: 200, collation: "utf8_general_ci"
    t.string "image", limit: 100
    t.integer "quantity"
    t.float "price"
    t.string "description", limit: 45
  end

  create_table "products", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
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

  create_table "user", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "fullname", limit: 50, collation: "utf8_general_ci"
    t.string "image", limit: 45
    t.string "address", limit: 200, collation: "utf8_general_ci"
    t.string "phone", limit: 15
    t.string "day_of_birth", limit: 45
  end

  add_foreign_key "images", "products"
  add_foreign_key "products", "categories"
  add_foreign_key "products", "manufacturers"
end
