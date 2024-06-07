# frozen_string_literal: true

module ActiveIntelligence
  module LLM
    class Adapter < ActiveIntelligence::Adapter

      def generate(prompt, options = {}, &block)
        raise NotImplementedError
      end

      def reply(chat, options = {}, &block)
        raise NotImplementedError
      end
    end
  end
end
