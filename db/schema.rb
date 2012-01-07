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

ActiveRecord::Schema.define(:version => 20120105050954) do

  create_table "batches", :force => true do |t|
    t.string   "name",           :limit => 25
    t.string   "subject"
    t.string   "from"
    t.string   "image_filename"
    t.text     "message"
    t.boolean  "active",                       :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "batches", ["active"], :name => "index_batches_on_active"
  add_index "batches", ["name"], :name => "index_batches_on_name", :unique => true

  create_table "facebook_users", :id => false, :force => true do |t|
    t.integer  "fb_uid",               :limit => 8, :null => false
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "access_token"
    t.datetime "access_token_expires"
  end

  create_table "households", :force => true do |t|
    t.string   "description"
    t.string   "greeting"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "active_notes_count", :default => 0
  end

  create_table "notes", :force => true do |t|
    t.text     "message"
    t.string   "to"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "household_id"
    t.integer  "sender_id"
    t.string   "from"
    t.string   "subject"
    t.integer  "batch_id",       :null => false
    t.string   "image_filename"
  end

  create_table "people", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.integer  "household_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login",        :limit => 40
    t.string   "identity_url"
    t.string   "email",        :limit => 100
    t.datetime "activated_at"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "fb_uid",       :limit => 8
    t.string   "first_name"
    t.string   "last_name"
  end

  add_index "users", ["fb_uid"], :name => "users_fb_uid_idx"
  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

end
