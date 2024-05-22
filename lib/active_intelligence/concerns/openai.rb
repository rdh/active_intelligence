# frozen_string_literal: true

require 'openai'

module ActiveIntelligence
  module Concerns
    module OpenAI
      extend ActiveSupport::Concern

      included do
        def client
          @client ||= ::OpenAI::Client.new(settings)
        end

        def default_parameters
          settings.except(
            :adapter,
            :access_token,
            :chat_message_limit,
            :organization_id,
            :request_timeout
          )
        end
      end
    end
  end
end
