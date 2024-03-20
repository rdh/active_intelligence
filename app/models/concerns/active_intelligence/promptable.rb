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
        path = self.class.name.pluralize.underscore
        path = [path, name].join('/') if name

        lookup_context = ActionView::LookupContext.new([Rails.root.join('app/prompts')])
        context = ActionView::Base.with_empty_template_cache.new(lookup_context, { self: self }, nil)
        renderer = ActionView::Renderer.new(lookup_context)

        return renderer.render(context, { template: path, formats: [:text], handlers: [:erb] })
      end
    end
  end
end
