# frozen_string_literal: true

module ActiveIntelligence
  module LLM
    class MockAdapter < Adapter

      def generate(_prompt, _options = {})
        return 'This is a mock response'
      end

      def reply(_chat, _options = {})
        return 'This is a mock response'
      end
    end
  end
end
