# frozen_string_literal: true

describe ActiveIntelligence::Chat do
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
      expect(subject).to have_db_column(:messages_count)
                           .of_type(:integer)
                           .with_options(default: 0, null: false)

      expect(subject).to have_db_column(:created_at).of_type(:datetime)
      expect(subject).to have_db_column(:updated_at).of_type(:datetime)
    end
  end

  #############################################################################
  # Associations

  describe 'associations' do

    it 'has many chat messages' do
      expect(subject).to have_many(:messages)
                           .class_name(ActiveIntelligence::ChatMessage.to_s)
                           .dependent(:destroy)
                           .counter_cache(:messages_count)
    end
  end

  #############################################################################
  # Counter Caches

  describe 'counter caches' do

    let(:chat) { create(:chat) }

    it 'increments messages_count' do
      expect { create(:chat_message, chat:) }
        .to change { chat.reload.messages_count }
              .from(0)
              .to(1)
    end
  end
end
