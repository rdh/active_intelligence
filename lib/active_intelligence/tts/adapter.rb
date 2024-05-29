# frozen_string_literal: true

module ActiveIntelligence
  module TTS
    class Adapter < ActiveIntelligence::Adapter

      def generate(text, options = {})
        raise NotImplementedError
      end
    end
  end
end
