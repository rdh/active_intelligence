# frozen_string_literal: true

module ActiveIntelligence
  module Embeddings
    class MockAdapter < Adapter

      def generate(_text, _options = {})
        return []
      end
    end
  end
end
