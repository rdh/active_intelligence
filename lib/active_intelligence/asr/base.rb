# frozen_string_literal: true

module ActiveIntelligence
  module ASR
    class Base

      attr_reader :settings

      def initialize(settings)
        @settings = settings
      end

      def transcribe(file, options = {})
        raise NotImplementedError
      end
    end
  end
end
