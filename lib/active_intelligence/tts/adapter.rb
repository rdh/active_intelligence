# frozen_string_literal: true

module ActiveIntelligence
  module TTS
    class Adapter < ActiveIntelligence::Adapter

      def generate(text, options = {})
        raise NotImplementedError
      end

      def generate_file(text, path, options = {})
        File.binwrite(path, generate(text, options))
      end
    end
  end
end
