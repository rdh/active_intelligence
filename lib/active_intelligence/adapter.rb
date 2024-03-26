# frozen_string_literal: true

module ActiveIntelligence
  class Adapter
    attr_reader :settings

    def initialize(settings)
      @settings = settings
    end
  end
end
