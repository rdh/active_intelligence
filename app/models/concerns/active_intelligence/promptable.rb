# frozen_string_literal: true

module ActiveIntelligence
  module Promptable
    extend ActiveSupport::Concern

    included do
      def from_llm(template = nil, options = {})
        adapter = options[:adapter]
        llm = ActiveIntelligence::LLM::Config.new.adapter(adapter)
        return llm.generate(to_prompt(template))
      end

      def to_prompt(name = nil, options = {})
        template = self.class.name.pluralize.underscore
        template = [template, name].join('/') if name

        assigns = { self: self }.merge(options[:assigns] || {})
        prompt = ActiveIntelligence::LLM::Prompt.new(template, assigns)
        return prompt.render
      end
    end
  end
end
