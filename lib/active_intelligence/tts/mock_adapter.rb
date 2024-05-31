# frozen_string_literal: true

module ActiveIntelligence
  module TTS
    class MockAdapter < Adapter

      def generate(_text, _options = {})
        return nil if settings[:path].nil?

        return File.open(settings[:path]).read
      end
    end
  end
end
