# frozen_string_literal: true

module ActiveIntelligence
  module LLM
    class OpenAIAdapter < Adapter
      include ActiveIntelligence::Concerns::OpenAI

      def generate(prompt, _options = {}, &block)
        parameters = default_parameters
        parameters[:messages] = [{ role: 'user', content: prompt }]

        return chat(parameters, &block)
      end

      def reply(chat, options = {}, &block)
        options = options.dup
        parameters = default_parameters
        parameters[:messages] = messages(chat, options)

        return chat(parameters, &block)
      end

      private

      def chat(parameters, &block)
        logger.debug [self.class.name, __method__, 'parameters', parameters]
        return stream(parameters, &block) if block_given?

        response = client.chat(parameters:)
        logger.debug [self.class.name, __method__, 'response', response]

        return response.dig('choices', 0, 'message', 'content')
      end

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

      def stream(parameters, &)
        response = []

        parameters[:stream] = proc do |chunk, _bytesize|
          logger.debug [self.class.name, __method__, 'chunk', chunk]

          delta = chunk.dig('choices', 0, 'delta', 'content')
          response << delta
          yield delta if delta
        end

        client.chat(parameters:)

        return response.join
      end
    end
  end
end
