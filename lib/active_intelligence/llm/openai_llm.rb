# frozen_string_literal: true

require 'openai'

module ActiveIntelligence
  module LLM
    class OpenAILLM < BaseLLM

      def client
        @client ||= OpenAI::Client.new(@settings)
      end

      def generate(prompt, options = {})
        parameters = settings.except(:adapter, :access_token, :organization_id)
        parameters[:messages] = [{ role: 'user', content: prompt }]

        response = client.chat(parameters:)

        return response.dig('choices', 0, 'message', 'content')
      end
    end
  end
end
