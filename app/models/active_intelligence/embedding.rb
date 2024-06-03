# frozen_string_literal: true

module ActiveIntelligence
  class Embedding < ApplicationRecord
    has_neighbors :embedding
  end
end
