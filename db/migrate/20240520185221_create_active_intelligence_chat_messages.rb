class CreateActiveIntelligenceChatMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :active_intelligence_chat_messages do |t|
      t.references :chat, null: false
      t.integer :role, null: false
      t.text :content
      t.timestamps
    end
  end
end
