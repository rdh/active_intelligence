# frozen_string_literal: true

module ActiveIntelligence
  module TTS
    class ElevenLabsAdapter < Adapter

      def generate(text, options = {})
        raise NotImplementedError
      end
    end
  end
end
