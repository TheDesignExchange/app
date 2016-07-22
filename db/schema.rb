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

ActiveRecord::Schema.define(version: 20160722205240) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

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

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

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
    t.string   "name"
    t.string   "main_image"
    t.text     "url"
    t.text     "overview"
    t.text     "resource"
    t.text     "problem"
    t.text     "process"
    t.text     "outcome"
    t.integer  "development_cycle"
    t.integer  "design_phase"
    t.integer  "project_domain"
    t.integer  "customer_type"
    t.integer  "user_age"
    t.integer  "privacy_level"
    t.integer  "social_setting"
    t.boolean  "customer_is_user"
    t.boolean  "remote_project"
    t.integer  "num_of_designers"
    t.integer  "num_of_users"
    t.integer  "time_period"
    t.text     "time_unit"
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "characteristic_groups", force: true do |t|
    t.integer  "method_category_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "characteristics", force: true do |t|
    t.integer  "characteristic_group_id"
    t.string   "name"
    t.text     "description",             default: ""
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "citations", force: true do |t|
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "collections", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "owner_id"
    t.integer  "design_method_id"
    t.boolean  "is_private"
    t.text     "overview"
  end

  add_index "collections", ["design_method_id"], name: "index_collections_on_design_method_id", using: :btree
  add_index "collections", ["user_id"], name: "index_collections_on_user_id", using: :btree

  create_table "comments", force: true do |t|
    t.text     "text"
    t.integer  "user_id"
    t.integer  "design_method_id"
    t.integer  "parent_id"
    t.integer  "display_order"
    t.integer  "indent"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "companies", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "domain"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contacts", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "design_methods", force: true do |t|
    t.string   "name",                            null: false
    t.text     "overview",                        null: false
    t.text     "process",                         null: false
    t.string   "aka"
    t.integer  "owner_id",                        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "num_of_designers",   default: 1
    t.integer  "num_of_users",       default: 1
    t.integer  "time_period",        default: 0
    t.string   "time_unit",          default: ""
    t.string   "main_image"
    t.integer  "likes",              default: 0
    t.text     "synonyms"
    t.text     "benefits"
    t.text     "limitations"
    t.text     "skills"
    t.text     "usage"
    t.text     "online_resources"
    t.text     "history"
    t.text     "critiques"
    t.text     "additional_reading"
    t.text     "references"
    t.integer  "collection_id"
    t.string   "videoURL"
    t.text     "prod_image"
  end

  add_index "design_methods", ["collection_id"], name: "index_design_methods_on_collection_id", using: :btree

  create_table "discussion_replies", force: true do |t|
    t.text     "text"
    t.integer  "user_id"
    t.integer  "discussion_id"
    t.integer  "discussion_reply_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "discussion_replies", ["discussion_id"], name: "index_discussion_replies_on_discussion_id", using: :btree
  add_index "discussion_replies", ["discussion_reply_id"], name: "index_discussion_replies_on_discussion_reply_id", using: :btree
  add_index "discussion_replies", ["user_id"], name: "index_discussion_replies_on_user_id", using: :btree

  create_table "discussions", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "user_id",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "discussions", ["user_id"], name: "index_discussions_on_user_id", using: :btree

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

  create_table "method_characteristics", force: true do |t|
    t.integer  "design_method_id"
    t.integer  "characteristic_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "method_characteristics", ["characteristic_id"], name: "index_method_characteristics_on_characteristic_id", using: :btree
  add_index "method_characteristics", ["design_method_id", "characteristic_id"], name: "char_index", unique: true, using: :btree
  add_index "method_characteristics", ["design_method_id"], name: "index_method_characteristics_on_design_method_id", using: :btree

  create_table "method_citations", force: true do |t|
    t.integer  "design_method_id"
    t.integer  "citation_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "method_citations", ["citation_id"], name: "index_method_citations_on_citation_id", using: :btree
  add_index "method_citations", ["design_method_id", "citation_id"], name: "index_method_citations_on_design_method_id_and_citation_id", unique: true, using: :btree
  add_index "method_citations", ["design_method_id"], name: "index_method_citations_on_design_method_id", using: :btree

  create_table "method_collections", force: true do |t|
    t.integer  "design_method_id"
    t.integer  "collection_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "case_study_id"
  end

  add_index "method_collections", ["case_study_id"], name: "index_method_collections_on_case_study_id", using: :btree

  create_table "method_favorites", force: true do |t|
    t.integer  "user_id"
    t.integer  "design_method_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "method_likes", force: true do |t|
    t.integer  "user_id"
    t.integer  "design_method_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "method_likes", ["user_id", "design_method_id"], name: "index_method_likes_on_user_id_and_design_method_id", unique: true, using: :btree

  create_table "method_variations", force: true do |t|
    t.integer  "parent_id"
    t.integer  "variant_id"
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

  create_table "tags", force: true do |t|
    t.integer  "design_method_id"
    t.integer  "case_study_id"
    t.integer  "discussion_id"
    t.integer  "user_id"
    t.string   "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "content_type",     default: "tag"
  end

  create_table "user_methods", force: true do |t|
    t.integer  "user_id",          null: false
    t.integer  "design_method_id", null: false
    t.integer  "type_id",          null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_methods", ["design_method_id"], name: "index_user_methods_on_design_method_id", using: :btree
  add_index "user_methods", ["user_id", "design_method_id"], name: "index_user_methods_on_user_id_and_design_method_id", unique: true, using: :btree
  add_index "user_methods", ["user_id"], name: "index_user_methods_on_user_id", using: :btree

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
    t.string   "first_name"
    t.string   "last_name"
    t.string   "username"
    t.string   "profile_picture"
    t.string   "phone_number"
    t.string   "website"
    t.string   "facebook"
    t.string   "twitter"
    t.string   "linkedin"
    t.string   "about_text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "roles_mask"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
