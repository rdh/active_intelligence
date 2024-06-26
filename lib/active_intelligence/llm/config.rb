# frozen_string_literal: true

module ActiveIntelligence
  module LLM
    class Config < ActiveIntelligence::Config; end

    def self.adapter(key = nil)
      Config.adapter(key)
    end
  end
end
