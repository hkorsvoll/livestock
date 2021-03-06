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

ActiveRecord::Schema.define(:version => 20130906195808) do

  create_table "animalrelations", :force => true do |t|
    t.integer  "animal_id"
    t.integer  "parent_id"
    t.string   "relation_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "animals", :force => true do |t|
    t.string   "name"
    t.string   "id_tag"
    t.date     "birth_date"
    t.date     "death_date"
    t.string   "sex"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "father_id"
    t.integer  "mother_id"
    t.integer  "owner_id"
  end

  create_table "animals_notes", :force => true do |t|
    t.integer "animal_id"
    t.integer "note_id"
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "matings", :force => true do |t|
    t.integer  "animal_id"
    t.date     "mating_date"
    t.integer  "uncertainty"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "male_id"
  end

  add_index "matings", ["animal_id"], :name => "index_matings_on_animal_id"

  create_table "notes", :force => true do |t|
    t.text     "content"
    t.date     "date_from"
    t.date     "date_to"
    t.integer  "category_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "owner_id"
  end

  create_table "owners", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "pnum"
    t.string   "orgnum"
    t.string   "prodnum"
  end

  create_table "owners_users", :force => true do |t|
    t.integer "owner_id", :null => false
    t.integer "user_id",  :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin"
  end

end
