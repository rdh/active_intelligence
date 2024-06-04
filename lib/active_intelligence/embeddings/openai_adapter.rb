# frozen_string_literal: true

module ActiveIntelligence
  module Embeddings
    class OpenAIAdapter < Adapter
      include ActiveIntelligence::Concerns::OpenAI

      def generate(text, options = {})
        parameters = default_parameters.merge(options)
        parameters[:input] = text

        response = client.embeddings(parameters:)
        return response.dig('data', 0, 'embedding')
      end
    end
  end
end
