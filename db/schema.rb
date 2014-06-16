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

ActiveRecord::Schema.define(version: 20140613234513) do

  create_table "active_admin_comments", force: true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"

  create_table "admin_users", force: true do |t|
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

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true

  create_table "bootsy_image_galleries", force: true do |t|
    t.integer  "bootsy_resource_id"
    t.string   "bootsy_resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bootsy_images", force: true do |t|
    t.string   "image_file"
    t.integer  "image_gallery_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "case_studies", force: true do |t|
    t.string   "mainImage",         default: ""
    t.string   "title",             default: ""
    t.string   "methods",           default: ""
    t.string   "url",               default: ""
    t.string   "timePeriod",        default: ""
    t.integer  "development_cycle"
    t.integer  "design_phase"
    t.integer  "project_domain"
    t.integer  "customer_type"
    t.integer  "user_age"
    t.integer  "privacy_level"
    t.integer  "social_setting"
    t.text     "description"
    t.boolean  "customerIsUser",    default: false
    t.boolean  "remoteProject",     default: false
    t.integer  "company_id"
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

  create_table "comments", force: true do |t|
    t.integer  "commentable_id",   default: 0
    t.string   "commentable_type"
    t.string   "title"
    t.text     "body"
    t.string   "subject"
    t.integer  "user_id",          default: 0, null: false
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["commentable_id", "commentable_type"], name: "index_comments_on_commentable_id_and_commentable_type"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

  create_table "companies", force: true do |t|
    t.string   "name",       default: ""
    t.string   "domain",     default: ""
    t.string   "email",      default: ""
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contacts", force: true do |t|
    t.string   "name",       default: ""
    t.string   "email",      default: ""
    t.string   "phone",      default: ""
    t.integer  "company_id"
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

  create_table "mc_relations", force: true do |t|
    t.integer  "parent_id"
    t.integer  "child_id"
    t.integer  "distance"
    t.string   "description", default: "subclass"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "mc_relations", ["child_id"], name: "index_mc_relations_on_child_id"
  add_index "mc_relations", ["parent_id", "child_id"], name: "mcrelations_index", unique: true
  add_index "mc_relations", ["parent_id"], name: "index_mc_relations_on_parent_id"

  create_table "method_case_studies", force: true do |t|
    t.integer  "case_study_id"
    t.integer  "design_method_id"
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

  create_table "method_favorites", force: true do |t|
    t.integer  "user_id"
    t.integer  "design_method_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "resources", force: true do |t|
    t.string   "name",              default: ""
    t.boolean  "permission_to_use", default: false
    t.string   "type",              default: ""
    t.integer  "company_id"
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
