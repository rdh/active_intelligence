# frozen_string_literal: true

describe ActiveIntelligence::Embedding do

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
      expect(subject).to have_db_column(:embeddable_type).of_type(:string).with_options(null: false)
      expect(subject).to have_db_column(:embeddable_id).of_type(:integer).with_options(null: false)
      expect(subject).to have_db_column(:embedding).of_type(:vector).with_options(limit: 1536, null: false)

      expect(subject).to have_db_column(:created_at).of_type(:datetime)
      expect(subject).to have_db_column(:updated_at).of_type(:datetime)
    end

    it 'has indexes' do
      expect(subject).to have_db_index(%i[embeddable_type embeddable_id])
      expect(subject).to have_db_index(:embedding)
    end
  end

  #############################################################################
  # Associations

  describe 'associations' do

    it 'has many chat message embeddings' do
      expect(subject).to have_many(:chat_message_embeddings)
                           .dependent(:destroy)
                           .inverse_of(:embedding)
    end
  end
end
