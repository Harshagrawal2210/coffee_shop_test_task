# frozen_string_literal: true

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

ActiveRecord::Schema.define(version: 20_181_224_091_437) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'categories', force: :cascade do |t|
    t.string 'title'
    t.text 'description'
    t.integer 'sub_category_id', default: 0
    t.integer 'status', default: 1
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.integer 'row_order'
    t.index ['row_order'], name: 'index_categories_on_row_order'
  end

  create_table 'locations', force: :cascade do |t|
    t.string 'title'
    t.text 'address'
    t.string 'fax'
    t.string 'office_telephone'
    t.string 'longitude'
    t.string 'latitude'
    t.string 'licence_no'
    t.integer 'row_order'
    t.string 'url_handle'
    t.string 'placeid'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.datetime 'start_time'
    t.datetime 'end_time'
    t.string 'aval_week', default: %w[0 1 2 3 4 5 6], array: true
    t.datetime 'location_open'
    t.datetime 'location_close'
    t.integer 'interval'
    t.integer 'day_out'
  end

  create_table 'order_item_attrs', force: :cascade do |t|
    t.bigint 'order_item_id'
    t.bigint 'order_id'
    t.bigint 'category_id'
    t.string 'category_name'
    t.bigint 'product_id'
    t.string 'product_name'
    t.string 'product_description'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['category_id'], name: 'index_order_item_attrs_on_category_id'
    t.index ['order_id'], name: 'index_order_item_attrs_on_order_id'
    t.index ['order_item_id'], name: 'index_order_item_attrs_on_order_item_id'
    t.index ['product_id'], name: 'index_order_item_attrs_on_product_id'
  end

  create_table 'order_items', force: :cascade do |t|
    t.bigint 'order_id'
    t.bigint 'product_id'
    t.string 'product_name'
    t.text 'product_description'
    t.integer 'product_qty'
    t.string 'product_qty_type'
    t.boolean 'is_attribute', default: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.decimal 'price', precision: 10, scale: 2
    t.index ['order_id'], name: 'index_order_items_on_order_id'
    t.index ['product_id'], name: 'index_order_items_on_product_id'
  end

  create_table 'orders', force: :cascade do |t|
    t.string 'order_no'
    t.integer 'user_id', default: 0
    t.string 'name'
    t.string 'email'
    t.string 'phone'
    t.decimal 'gross_amout', precision: 10, scale: 2
    t.decimal 'total_amout', precision: 10, scale: 2
    t.decimal 'tax_amout', precision: 10, scale: 2
    t.decimal 'amout_receive', precision: 10, scale: 2
    t.decimal 'amout_pending', precision: 10, scale: 2
    t.string 'uniq_token'
    t.integer 'status', default: 0
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.text 'spec_request'
    t.datetime 'order_date'
    t.datetime 'order_time'
    t.text 'stripe_data'
    t.string 'stripe_trans_id'
    t.bigint 'location_id'
    t.string 'customer_id'
    t.text 'shipping_address'
    t.string 'order_type'
    t.decimal 'sales_tax', precision: 10, scale: 3
    t.index ['location_id'], name: 'index_orders_on_location_id'
  end

  create_table 'product_to_attributes', force: :cascade do |t|
    t.string 'title'
    t.string 'description'
    t.bigint 'category_id'
    t.bigint 'product_id'
    t.string 'qty_type'
    t.integer 'qty'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.boolean 'is_required', default: true
    t.index ['category_id'], name: 'index_product_to_attributes_on_category_id'
    t.index ['product_id'], name: 'index_product_to_attributes_on_product_id'
  end

  create_table 'product_to_locations', force: :cascade do |t|
    t.bigint 'product_id'
    t.bigint 'location_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['location_id'], name: 'index_product_to_locations_on_location_id'
    t.index ['product_id'], name: 'index_product_to_locations_on_product_id'
  end

  create_table 'product_to_qties', force: :cascade do |t|
    t.bigint 'product_id'
    t.float 'price'
    t.string 'qty_type'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['product_id'], name: 'index_product_to_qties_on_product_id'
  end

  create_table 'products', force: :cascade do |t|
    t.string 'title'
    t.text 'description'
    t.bigint 'category_id'
    t.integer 'status', default: 1
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.float 'price'
    t.string 'aval_week', default: %w[0 1 2 3 4 5 6], array: true
    t.integer 'row_order'
    t.index ['category_id'], name: 'index_products_on_category_id'
    t.index ['row_order'], name: 'index_products_on_row_order'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.integer 'sign_in_count', default: 0, null: false
    t.datetime 'current_sign_in_at'
    t.datetime 'last_sign_in_at'
    t.inet 'current_sign_in_ip'
    t.inet 'last_sign_in_ip'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'name'
    t.string 'mobile'
    t.string 'u_type', default: 'other'
    t.boolean 'image_processing'
    t.text 'all_location', default: [], array: true
    t.text 'permission', default: [], array: true
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
  end

  add_foreign_key 'order_item_attrs', 'categories'
  add_foreign_key 'order_item_attrs', 'order_items'
  add_foreign_key 'order_item_attrs', 'orders'
  add_foreign_key 'order_item_attrs', 'products'
  add_foreign_key 'order_items', 'orders'
  add_foreign_key 'order_items', 'products'
  add_foreign_key 'orders', 'locations'
  add_foreign_key 'product_to_attributes', 'categories'
  add_foreign_key 'product_to_attributes', 'products'
  add_foreign_key 'product_to_locations', 'locations'
  add_foreign_key 'product_to_locations', 'products'
  add_foreign_key 'product_to_qties', 'products'
  add_foreign_key 'products', 'categories'
end
