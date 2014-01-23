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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20131024173832) do

  create_table "case_studies", force: true do |t|
    t.string   "company"
    t.integer  "company_id"
    t.string   "name"
    t.string   "contact"
    t.string   "contact_information"
    t.string   "description"
    t.string   "resources"
    t.integer  "usability_rating"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categorizations", force: true do |t|
    t.integer  "design_method_id"
    t.integer  "method_category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categorizations", ["design_method_id", "method_category_id"], name: "cat_index", unique: true
  add_index "categorizations", ["design_method_id"], name: "index_categorizations_on_design_method_id"
  add_index "categorizations", ["method_category_id"], name: "index_categorizations_on_method_category_id"

  create_table "citations", force: true do |t|
    t.string   "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "design_methods", force: true do |t|
    t.string   "name",       null: false
    t.text     "overview",   null: false
    t.text     "process",    null: false
    t.text     "principle",  null: false
    t.integer  "owner_id",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "method_categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "method_citations", force: true do |t|
    t.integer  "design_method_id"
    t.integer  "citation_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "method_citations", ["citation_id"], name: "index_method_citations_on_citation_id"
  add_index "method_citations", ["design_method_id", "citation_id"], name: "index_method_citations_on_design_method_id_and_citation_id", unique: true
  add_index "method_citations", ["design_method_id"], name: "index_method_citations_on_design_method_id"

  create_table "method_ownerships", force: true do |t|
    t.integer  "user_id"
    t.integer  "design_method_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_methods", force: true do |t|
    t.integer  "user_id",          null: false
    t.integer  "design_method_id", null: false
    t.integer  "type_id",          null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_methods", ["design_method_id"], name: "index_user_methods_on_design_method_id"
  add_index "user_methods", ["user_id", "design_method_id"], name: "index_user_methods_on_user_id_and_design_method_id", unique: true
  add_index "user_methods", ["user_id"], name: "index_user_methods_on_user_id"

  create_table "users", force: true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
