# frozen_string_literal: true

module ActiveIntelligence
  class Adapter
    attr_reader :settings

    def initialize(settings = {})
      @settings = settings
    end

    def config(key, options, default = nil)
      options[key] || settings[key] || default
    end

    def logger
      Rails.logger
    end
  end
end
