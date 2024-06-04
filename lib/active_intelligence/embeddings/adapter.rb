# frozen_string_literal: true

module ActiveIntelligence
  module Embeddings
    class Adapter < ActiveIntelligence::Adapter

      def generate(prompt, options = {})
        raise NotImplementedError
      end
    end
  end
end
