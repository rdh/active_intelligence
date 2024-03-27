# frozen_string_literal: true

require 'openai'

module ActiveIntelligence
  module ASR
    class OpenAIAdapter < Adapter
      include ActiveIntelligence::Concerns::OpenAI

      def transcribe(file, options = {})
        raise NotImplementedError
      end
    end
  end
end
