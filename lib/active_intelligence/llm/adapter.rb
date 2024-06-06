# frozen_string_literal: true

module ActiveIntelligence
  module LLM
    class Adapter < ActiveIntelligence::Adapter

      def generate(prompt, options = {})
        raise NotImplementedError
      end

      def reply(chat, options = {})
        raise NotImplementedError
      end
    end
  end
end
