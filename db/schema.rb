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

ActiveRecord::Schema.define(version: 20161222135844) do

  create_table "answers", force: :cascade do |t|
    t.integer  "question_id"
    t.string   "content"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.boolean  "correct",     default: false, null: false
    t.index ["question_id"], name: "index_answers_on_question_id"
  end

  create_table "articles", force: :cascade do |t|
    t.integer  "specialist_id"
    t.string   "title"
    t.string   "author"
    t.string   "content"
    t.string   "source"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "explanation"
    t.string   "article_image_file_name"
    t.string   "article_image_content_type"
    t.integer  "article_image_file_size"
    t.datetime "article_image_updated_at"
    t.index ["specialist_id"], name: "index_articles_on_specialist_id"
  end

  create_table "facts", force: :cascade do |t|
    t.string   "title"
    t.string   "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "favorites", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "favorited_type"
    t.integer  "favorited_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["favorited_type", "favorited_id"], name: "index_favorites_on_favorited_type_and_favorited_id"
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "questions", force: :cascade do |t|
    t.integer  "article_id"
    t.string   "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["article_id"], name: "index_questions_on_article_id"
  end

  create_table "specialists", force: :cascade do |t|
    t.string   "name"
    t.string   "profession"
    t.string   "bio"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "article_id"
    t.integer  "tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["article_id"], name: "index_taggings_on_article_id"
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "firstname"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "remember_digest"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
    t.boolean  "admin",           default: false, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
