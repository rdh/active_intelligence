# frozen_string_literal: true

module ActiveIntelligence
  module ASR
    class Base < ActiveIntelligence::Adapter

      def transcribe(file, options = {})
        raise NotImplementedError
      end
    end
  end
end
