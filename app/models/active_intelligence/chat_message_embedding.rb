# frozen_string_literal: true

module ActiveIntelligence
  class ChatMessageEmbedding < ApplicationRecord

    belongs_to :message,
               class_name: ActiveIntelligence::ChatMessage.to_s,
               foreign_key: :chat_message_id,
               inverse_of: :chat_message_embeddings

    belongs_to :embedding, class_name: ActiveIntelligence::Embedding.to_s
  end
end
