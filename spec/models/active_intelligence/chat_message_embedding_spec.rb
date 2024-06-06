# frozen_string_literal: true

describe ActiveIntelligence::ChatMessageEmbedding do

  #############################################################################
  # Class

  describe 'class' do

    it 'is a subclass of ActiveIntelligence::ApplicationRecord' do
      expect(described_class.superclass).to eq(ActiveIntelligence::ApplicationRecord)
    end
  end

  #############################################################################
  # Database

  describe 'database' do

    it 'has columns' do
      expect(subject).to have_db_column(:chat_message_id).of_type(:integer).with_options(null: false)
      expect(subject).to have_db_column(:embedding_id).of_type(:integer).with_options(null: false)

      expect(subject).to have_db_column(:created_at).of_type(:datetime)
      expect(subject).to have_db_column(:updated_at).of_type(:datetime)
    end

    it 'has indexes' do
      expect(subject).to have_db_index(:chat_message_id)
      expect(subject).to have_db_index(:embedding_id)
    end
  end

  #############################################################################
  # Associations

  describe 'associations' do

    it 'belongs to a chat message' do
      expect(subject).to belong_to(:message)
                           .class_name(ActiveIntelligence::ChatMessage.to_s)
                           .with_foreign_key(:chat_message_id)
                           .inverse_of(:chat_message_embeddings)
    end

    it 'belongs to an embedding' do
      expect(subject).to belong_to(:embedding)
                           .class_name(ActiveIntelligence::Embedding.to_s)
    end
  end
end
