# frozen_string_literal: true

# SEE: https://www.toptal.com/ruby-on-rails/rails-service-objects-tutorial

module ActiveIntelligence
  class ApplicationService
    def self.call(*args, &block)
      new(*args, &block).call
    end

    def initialize(*_args, &_block); end
  end
end
