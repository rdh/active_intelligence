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

ActiveRecord::Schema[7.1].define(version: 2024_06_05_234023) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "vector"

  create_table "active_intelligence_chat_message_embeddings", force: :cascade do |t|
    t.bigint "chat_message_id", null: false
    t.bigint "embedding_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chat_message_id"], name: "idx_on_chat_message_id_efa2a8993e"
    t.index ["embedding_id"], name: "idx_on_embedding_id_16d71b199c"
  end

  create_table "active_intelligence_chat_messages", force: :cascade do |t|
    t.bigint "chat_id", null: false
    t.integer "role", null: false
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chat_id"], name: "index_active_intelligence_chat_messages_on_chat_id"
  end

  create_table "active_intelligence_chats", force: :cascade do |t|
    t.integer "messages_count", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "active_intelligence_embeddings", force: :cascade do |t|
    t.string "embeddable_type", null: false
    t.bigint "embeddable_id", null: false
    t.vector "embedding", limit: 1536, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["embeddable_type", "embeddable_id"], name: "index_active_intelligence_embeddings_on_embeddable"
    t.index ["embedding"], name: "index_active_intelligence_embeddings_on_embedding", opclass: :vector_cosine_ops, using: :hnsw
  end

end
