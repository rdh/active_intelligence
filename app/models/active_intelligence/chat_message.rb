# frozen_string_literal: true

module ActiveIntelligence
  class ChatMessage < ApplicationRecord

    belongs_to :chat,
               class_name: ActiveIntelligence::Chat.to_s,
               counter_cache: :messages_count

    has_many :chat_message_embeddings, dependent: :destroy, inverse_of: :message
    has_many :embeddings, through: :chat_message_embeddings

    enum role: { assistant: 0, user: 1 }

    def embeddables
      embeddings.map(&:embeddable)
    end
  end
end
