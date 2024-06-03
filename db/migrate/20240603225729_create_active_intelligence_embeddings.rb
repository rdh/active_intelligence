class CreateActiveIntelligenceEmbeddings < ActiveRecord::Migration[7.1]
  def change
    create_table :active_intelligence_embeddings do |t|
      t.references :embeddable, polymorphic: true, null: false
      t.vector :embedding, limit: 1536, null: false
      t.timestamps
    end

    add_index :active_intelligence_embeddings, :embedding, using: :hnsw, opclass: :vector_cosine_ops
  end
end
