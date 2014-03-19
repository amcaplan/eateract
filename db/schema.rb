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

ActiveRecord::Schema.define(version: 20140319184656) do

  create_table "links", force: true do |t|
    t.string   "name"
    t.string   "type"
    t.string   "url"
    t.text     "summary"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "meal_links", force: true do |t|
    t.integer  "meal_id"
    t.integer  "link_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "meal_links", ["link_id"], name: "index_meal_links_on_link_id"
  add_index "meal_links", ["meal_id"], name: "index_meal_links_on_meal_id"

  create_table "meal_people", force: true do |t|
    t.integer  "meal_id"
    t.integer  "person_id"
    t.boolean  "host"
    t.boolean  "attending"
    t.string   "host_relationship"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "meal_people", ["meal_id"], name: "index_meal_people_on_meal_id"
  add_index "meal_people", ["person_id"], name: "index_meal_people_on_person_id"

  create_table "meal_recipes", force: true do |t|
    t.integer  "meal_id"
    t.integer  "recipe_id"
    t.decimal  "quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "meal_recipes", ["meal_id"], name: "index_meal_recipes_on_meal_id"
  add_index "meal_recipes", ["recipe_id"], name: "index_meal_recipes_on_recipe_id"

  create_table "meals", force: true do |t|
    t.datetime "time"
    t.integer  "topic_id"
    t.string   "cuisine_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "meals", ["topic_id"], name: "index_meals_on_topic_id"

  create_table "people", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ratings", force: true do |t|
    t.float    "number"
    t.integer  "meal_id"
    t.integer  "person_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ratings", ["meal_id"], name: "index_ratings_on_meal_id"
  add_index "ratings", ["person_id"], name: "index_ratings_on_person_id"

  create_table "recipes", force: true do |t|
    t.string   "name"
    t.string   "cuisine_type"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "topic_links", force: true do |t|
    t.integer  "topic_id"
    t.integer  "link_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "topic_links", ["link_id"], name: "index_topic_links_on_link_id"
  add_index "topic_links", ["topic_id"], name: "index_topic_links_on_topic_id"

  create_table "topics", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.integer  "person_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
    t.string   "img_url"
  end

  add_index "users", ["person_id"], name: "index_users_on_person_id"

end
