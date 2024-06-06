# frozen_string_literal: true

module ActiveIntelligence
  class Embedding < ApplicationRecord
    belongs_to :embeddable, polymorphic: true

    has_many :chat_message_embeddings, dependent: :destroy, inverse_of: :embedding

    has_neighbors :embedding
  end
end
