# frozen_string_literal: true

module ActiveIntelligence
  class Chat < ApplicationRecord
    include Promptable

    has_many :messages,
             class_name: ActiveIntelligence::ChatMessage.to_s,
             dependent: :destroy,
             counter_cache: :messages_count

    def as_json(options = {})
      if options.empty?
        options[:only] = %i[id created_at updated_at]
        options[:methods] = %i[messages_count]
        options[:include] = [messages: { only: %i[id role content created_at updated_at] }]
      end

      super(options)
    end

    def reply(options = {}, &block)
      options = options.dup
      llm = ActiveIntelligence::LLM::Config.new.adapter(options[:adapter])

      reply = llm.reply(self, options, &block)
      return messages.create!(role: 'assistant', content: reply)
    end
  end
end
