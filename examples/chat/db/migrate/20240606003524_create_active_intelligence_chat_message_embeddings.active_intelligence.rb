# This migration comes from active_intelligence (originally 20240605234023)
class CreateActiveIntelligenceChatMessageEmbeddings < ActiveRecord::Migration[7.1]
  def change
    create_table :active_intelligence_chat_message_embeddings do |t|
      t.references :chat_message, null: false
      t.references :embedding, null: false
      t.timestamps
    end
  end
end
