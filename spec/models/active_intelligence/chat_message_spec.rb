# frozen_string_literal: true

describe ActiveIntelligence::ChatMessage do

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
      expect(subject).to have_db_column(:chat_id).of_type(:integer).with_options(null: false)
      expect(subject).to have_db_column(:role).of_type(:integer).with_options(null: false)
      expect(subject).to have_db_column(:content).of_type(:text)

      expect(subject).to have_db_column(:created_at).of_type(:datetime)
      expect(subject).to have_db_column(:updated_at).of_type(:datetime)
    end

    it 'has indexes' do
      expect(subject).to have_db_index(:chat_id)
    end
  end

  #############################################################################
  # Associations

  describe 'associations' do

    it 'belongs to a chat' do
      expect(subject).to belong_to(:chat)
                           .class_name(ActiveIntelligence::Chat.to_s)
                           .counter_cache(:messages_count)
    end

    it 'has many chat message embeddings' do
      expect(subject).to have_many(:chat_message_embeddings)
                           .dependent(:destroy)
                           .inverse_of(:message)
    end

    it 'has many embeddings' do
      expect(subject).to have_many(:embeddings)
                           .through(:chat_message_embeddings)
    end
  end

  #############################################################################
  # Enums

  describe 'enums' do

    it 'enumerates role' do
      expect(subject).to define_enum_for(:role).with_values(%i[assistant user])
    end
  end
end
