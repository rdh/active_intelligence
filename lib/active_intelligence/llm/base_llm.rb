# frozen_string_literal: true

module ActiveIntelligence
  module LLM
    class BaseLLM
      def initialize(settings)
        @settings = settings
      end

      def generate(prompt, options = {})
        raise NotImplementedError
      end
    end
  end
end
