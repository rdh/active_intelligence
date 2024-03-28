# frozen_string_literal: true

module ActiveIntelligence
  module Concerns
    module Aws
      extend ActiveSupport::Concern

      included do
        def default_parameters
          settings.except(
            :adapter,
            :region,
            :access_key_id,
            :secret_access_key,
            :bucket,
            :folder,
            :sleep
          )
        end
      end
    end
  end
end
