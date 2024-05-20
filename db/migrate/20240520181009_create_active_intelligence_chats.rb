class CreateActiveIntelligenceChats < ActiveRecord::Migration[7.1]
  def change
    create_table :active_intelligence_chats do |t|
      t.integer :messages_count, default: 0, null: false
      t.timestamps
    end
  end
end
