# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 20_230_808_012_736) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'transaction_categories', force: :cascade do |t|
    t.string 'name', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'transaction_category_mappings', force: :cascade do |t|
    t.string 'merchant_name'
    t.bigint 'transaction_category_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index %w[merchant_name transaction_category_id], name: 'index__merchant_name_and_transaction_category_id', unique: true
    t.index ['transaction_category_id'], name: 'index_transaction_category_mappings_on_transaction_category_id'
  end

  create_table 'transactions', force: :cascade do |t|
    t.decimal 'amount', null: false
    t.date 'date', null: false
    t.string 'merchant_name'
    t.bigint 'transaction_category_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['transaction_category_id'], name: 'index_transactions_on_transaction_category_id'
  end

  add_foreign_key 'transaction_category_mappings', 'transaction_categories'
  add_foreign_key 'transactions', 'transaction_categories'
end
