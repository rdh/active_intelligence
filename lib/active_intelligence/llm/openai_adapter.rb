# frozen_string_literal: true

module ActiveIntelligence
  module LLM
    class OpenAIAdapter < Adapter
      include ActiveIntelligence::Concerns::OpenAI

      def chat(parameters)
        response = client.chat(parameters:)
        return response.dig('choices', 0, 'message', 'content')
      end

      def generate(prompt, _options = {})
        parameters = default_parameters
        parameters[:messages] = [{ role: 'user', content: prompt }]

        return chat(parameters)
      end

      def reply(chat, prompt, options = {})
        limit = options[:limit] || settings[:chat_message_limit] || 10

        parameters = default_parameters
        parameters[:messages] = [{ role: 'system', content: prompt }]

        messages = chat.messages.order(created_at: :desc).limit(limit).reverse
        messages.each do |message|
          parameters[:messages] << { role: message.role, content: message.content }
        end

        return chat(parameters)
      end
    end
  end
end
