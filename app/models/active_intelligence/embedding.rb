# frozen_string_literal: true

module ActiveIntelligence
  class Embedding < ApplicationRecord
    belongs_to :embeddable, polymorphic: true

    has_neighbors :embedding
  end
end
