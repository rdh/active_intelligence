# frozen_string_literal: true

module ActiveIntelligence
  module ASR
    class MockAdapter < Adapter

      def transcribe(_path, _options = {})
        return 'This is a mock transcription'
      end
    end
  end
end
