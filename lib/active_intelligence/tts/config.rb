# frozen_string_literal: true

module ActiveIntelligence
  module TTS
    class Config < ActiveIntelligence::Config
    end

    def self.adapter(key = nil)
      Config.adapter(key)
    end
  end
end
