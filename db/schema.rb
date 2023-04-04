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

ActiveRecord::Schema.define(version: 2023_04_04_130507) do

  create_table "categories", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.string "japanese_name"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "parent_category_id"
    t.integer "total_access", default: 0
    t.index ["parent_category_id"], name: "index_categories_on_parent_category_id"
  end

  create_table "chat_categories", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "category_id", null: false
    t.bigint "chat_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id"], name: "index_chat_categories_on_category_id"
    t.index ["chat_id"], name: "index_chat_categories_on_chat_id"
  end

  create_table "chat_likes", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "host_id"
    t.bigint "chat_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["chat_id"], name: "index_chat_likes_on_chat_id"
    t.index ["host_id"], name: "index_chat_likes_on_host_id"
    t.index ["user_id"], name: "index_chat_likes_on_user_id"
  end

  create_table "chats", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "host_id"
    t.bigint "room_id", null: false
    t.bigint "prequel_chat_id"
    t.text "question"
    t.text "answer"
    t.integer "number"
    t.integer "total_views", default: 0
    t.integer "total_likes", default: 0
    t.integer "total_comments", default: 0
    t.integer "total_chats", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["host_id"], name: "index_chats_on_host_id"
    t.index ["prequel_chat_id"], name: "index_chats_on_prequel_chat_id"
    t.index ["room_id"], name: "index_chats_on_room_id"
    t.index ["total_chats"], name: "index_chats_on_total_chats"
    t.index ["total_comments"], name: "index_chats_on_total_comments"
    t.index ["total_likes"], name: "index_chats_on_total_likes"
    t.index ["total_views"], name: "index_chats_on_total_views"
    t.index ["user_id"], name: "index_chats_on_user_id"
  end

  create_table "comment_likes", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "host_id"
    t.bigint "comment_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["comment_id"], name: "index_comment_likes_on_comment_id"
    t.index ["host_id"], name: "index_comment_likes_on_host_id"
    t.index ["user_id"], name: "index_comment_likes_on_user_id"
  end

  create_table "comments", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "host_id"
    t.bigint "chat_id", null: false
    t.bigint "comment_id"
    t.text "body"
    t.integer "total_views", default: 0
    t.integer "total_likes", default: 0
    t.integer "total_chats", default: 0
    t.integer "total_comments", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["chat_id"], name: "index_comments_on_chat_id"
    t.index ["comment_id"], name: "index_comments_on_comment_id"
    t.index ["host_id"], name: "index_comments_on_host_id"
    t.index ["total_chats"], name: "index_comments_on_total_chats"
    t.index ["total_comments"], name: "index_comments_on_total_comments"
    t.index ["total_likes"], name: "index_comments_on_total_likes"
    t.index ["total_views"], name: "index_comments_on_total_views"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "contexts", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "upper_chat_id", null: false
    t.bigint "bottom_chat_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["bottom_chat_id"], name: "index_contexts_on_bottom_chat_id"
    t.index ["upper_chat_id"], name: "index_contexts_on_upper_chat_id"
  end

  create_table "hosts", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "host_id", null: false
    t.string "source"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "room_categories", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "category_id", null: false
    t.bigint "room_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id"], name: "index_room_categories_on_category_id"
    t.index ["room_id"], name: "index_room_categories_on_room_id"
  end

  create_table "rooms", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "host_id"
    t.integer "total_views", default: 0
    t.integer "total_chats_likes", default: 0
    t.integer "total_comments_likes", default: 0
    t.integer "total_chats", default: 0
    t.integer "total_comments", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["host_id"], name: "index_rooms_on_host_id"
    t.index ["total_chats"], name: "index_rooms_on_total_chats"
    t.index ["total_chats_likes"], name: "index_rooms_on_total_chats_likes"
    t.index ["total_comments"], name: "index_rooms_on_total_comments"
    t.index ["total_comments_likes"], name: "index_rooms_on_total_comments_likes"
    t.index ["total_views"], name: "index_rooms_on_total_views"
    t.index ["user_id"], name: "index_rooms_on_user_id"
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "name"
    t.string "user_id", null: false
    t.text "description"
    t.string "image"
    t.integer "total_views", default: 0
    t.integer "total_chats_likes", default: 0
    t.integer "total_comments_likes", default: 0
    t.integer "total_chats", default: 0
    t.integer "total_comments", default: 0
    t.integer "total_notifications", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["name"], name: "index_users_on_name"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["total_chats"], name: "index_users_on_total_chats"
    t.index ["total_chats_likes"], name: "index_users_on_total_chats_likes"
    t.index ["total_comments"], name: "index_users_on_total_comments"
    t.index ["total_comments_likes"], name: "index_users_on_total_comments_likes"
    t.index ["total_views"], name: "index_users_on_total_views"
  end

  add_foreign_key "categories", "categories", column: "parent_category_id"
  add_foreign_key "chat_categories", "categories"
  add_foreign_key "chat_categories", "chats"
  add_foreign_key "chat_likes", "chats"
  add_foreign_key "chat_likes", "hosts"
  add_foreign_key "chat_likes", "users"
  add_foreign_key "chats", "chats", column: "prequel_chat_id"
  add_foreign_key "chats", "hosts"
  add_foreign_key "chats", "rooms"
  add_foreign_key "chats", "users"
  add_foreign_key "comment_likes", "comments"
  add_foreign_key "comment_likes", "hosts"
  add_foreign_key "comment_likes", "users"
  add_foreign_key "comments", "chats"
  add_foreign_key "comments", "comments"
  add_foreign_key "comments", "hosts"
  add_foreign_key "comments", "users"
  add_foreign_key "contexts", "chats", column: "bottom_chat_id"
  add_foreign_key "contexts", "chats", column: "upper_chat_id"
  add_foreign_key "room_categories", "categories"
  add_foreign_key "room_categories", "rooms"
  add_foreign_key "rooms", "hosts"
  add_foreign_key "rooms", "users"
end
