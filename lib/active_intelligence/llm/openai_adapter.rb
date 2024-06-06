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

      def reply(chat, options = {})
        options = options.dup
        parameters = default_parameters
        parameters[:messages] = messages(chat, options)

        return chat(parameters)
      end

      private

      def messages(chat, options)
        prompt = chat.to_prompt(options.delete(:name))
        messages = [{ role: 'system', content: prompt }]

        limit = options[:limit] || settings[:chat_message_limit] || 10
        query = chat.messages.order(created_at: :desc).limit(limit).reverse

        query.each do |message|
          messages << { role: message.role, content: message.content }
        end

        return messages
      end
    end
  end
end
