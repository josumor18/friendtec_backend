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

ActiveRecord::Schema.define(version: 20180608230235) do

  create_table "amigos", force: :cascade do |t|
    t.integer  "id_user1"
    t.integer  "id_user2"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "locations", force: :cascade do |t|
    t.integer  "id_user"
    t.float    "latitud"
    t.float    "longitud"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notifications", force: :cascade do |t|
    t.integer  "id_user"
    t.integer  "id_friend"
    t.integer  "id_post"
    t.boolean  "visto"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "posts", force: :cascade do |t|
    t.integer  "id_user"
    t.string   "contenido"
    t.string   "foto"
    t.datetime "fecha_hora"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "solicituds", force: :cascade do |t|
    t.integer  "id_user1"
    t.integer  "id_user2"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "carnet"
    t.string   "nombre"
    t.string   "email"
    t.string   "password"
    t.string   "auth_token"
    t.string   "foto"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "carrera"
    t.string   "avatar"
    t.string   "rfoto"
  end

end
