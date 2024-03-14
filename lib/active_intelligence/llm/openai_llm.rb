# frozen_string_literal: true

require 'openai'

module ActiveIntelligence
  module LLM
    class OpenAILLM < BaseLLM

      GLOBAL_SETTINGS = %i[
        adapter
        access_token
        organization_id
        request_timeout
      ].freeze

      def client
        @client ||= OpenAI::Client.new(@settings)
      end

      def generate(prompt, options = {})
        parameters = settings.except(*GLOBAL_SETTINGS)
        parameters[:messages] = [{ role: 'user', content: prompt }]

        response = client.chat(parameters:)

        return response.dig('choices', 0, 'message', 'content')
      end
    end
  end
end
