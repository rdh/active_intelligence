# frozen_string_literal: true

module ActiveIntelligence
  module LLM
    class Prompt

      def self.directory
        Rails.root.join('app/prompts')
      end

      def self.render
        lookup_context = ActionView::LookupContext.new([directory])
        context = ActionView::Base.with_empty_template_cache.new(lookup_context, {}, nil)
        renderer = ActionView::Renderer.new(lookup_context)
        return renderer.render(context, { template: 'prompt' })
      end
    end
  end
end
