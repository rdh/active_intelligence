# frozen_string_literal: true

module ActiveIntelligence
  module Embeddable
    extend ActiveSupport::Concern

    included do
      has_many :embeddings,
               as: :embeddable,
               class_name: ActiveIntelligence::Embedding.to_s,
               dependent: :destroy

      def add_embedding(text, options = {})
        adapter = ActiveIntelligence::Embeddings.adapter(options[:adapter])
        embedding = adapter.generate(text, options)
        embeddings.create!(embedding:)
      end
    end

    class_methods do
      def semantic_search(text, options = {})
        limit = options[:limit] || 10
        adapter = ActiveIntelligence::Embeddings.adapter(options[:adapter])
        embedding = adapter.generate(text, options)
        neighbors = ActiveIntelligence::Embedding.nearest_neighbors(:embedding, embedding, distance: 'cosine')
        return neighbors.first(limit).map(&:embeddable)
      end
    end
  end
end
