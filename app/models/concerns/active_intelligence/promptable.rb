# frozen_string_literal: true

module ActiveIntelligence
  module Promptable
    extend ActiveSupport::Concern

    included do
      def from_llm(template = nil, llm = nil)
        llm ||= ActiveIntelligence::LLM::Config.adapter
        return llm.generate(to_prompt(template))
      end

      def to_prompt(name = nil)
        template = self.class.name.pluralize.underscore
        template = [template, name].join('/') if name

        assigns = { self: self }
        prompt = ActiveIntelligence::LLM::Prompt.new(template, assigns)
        return prompt.render
      end
    end
  end
end
