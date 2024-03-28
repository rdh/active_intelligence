# frozen_string_literal: true

module ActiveIntelligence
  module ASR
    class Adapter < ActiveIntelligence::Adapter

      def transcribe(path, options = {})
        raise NotImplementedError
      end

      def logger
        Rails.logger
      end
    end
  end
end
