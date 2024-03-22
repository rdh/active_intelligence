# frozen_string_literal: true

module ActiveIntelligence
  module LLM
    class Prompt
      def initialize(template, assigns = {})
        @template = template
        @assigns = assigns
      end

      def render
        lookup_context = ActionView::LookupContext.new([Rails.root.join('app/prompts')])
        context = ActionView::Base.with_empty_template_cache.new(lookup_context, @assigns, nil)
        renderer = ActionView::Renderer.new(lookup_context)

        return renderer.render(context, { template: @template, formats: [:text], handlers: [:erb] })
      end
    end
  end
end
