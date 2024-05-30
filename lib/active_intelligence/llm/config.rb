# frozen_string_literal: true

module ActiveIntelligence
  module LLM
    class Config < ActiveIntelligence::Config; end
  end

  def self.adapter(key = nil)
    Config.adapter(key)
  end
end
