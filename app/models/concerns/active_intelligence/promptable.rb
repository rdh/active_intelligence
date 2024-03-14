# frozen_string_literal: true

module ActiveIntelligence
  module Promptable
    extend ActiveSupport::Concern

    included do
      def to_prompt(name = nil)
        template = self.class.prompt_file(name)
        ERB.new(template).result(binding)
      end

      def from_llm(name = nil, llm = nil)
        llm ||= ActiveIntelligence::LLM::Config.adapter
        return llm.generate(to_prompt(name))
      end
    end

    class_methods do
      def prompt_directory
        Rails.root.join('app/prompts')
      end

      def prompt_file(name)
        File.read(prompt_path(name))
      end

      def prompt_path(name)
        path = self.name.underscore
        path = [path, name].join('/') if name
        return prompt_directory.join("#{path}.erb")
      end
    end
  end
end
