# frozen_string_literal: true

require 'openai'

module ActiveIntelligence
  module LLM
    class OpenAIAdapter < Adapter
      include ActiveIntelligence::Concerns::OpenAI

      def generate(prompt, _options = {})
        parameters = default_parameters
        parameters[:messages] = [{ role: 'user', content: prompt }]

        response = client.chat(parameters:)

        return response.dig('choices', 0, 'message', 'content')
      end
    end
  end
end
