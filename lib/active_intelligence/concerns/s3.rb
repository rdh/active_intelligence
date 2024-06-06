# frozen_string_literal: true

# This concern is intended for use in ActiveIntelligence adapters,
# but it can easily be used in any class that exposes a settings hash
# with the required keys:
# - :region
# - :access_key_id
# - :secret_access_key
# - :bucket
#
# :folder is optional.  Alternatively a full path can be passed as key.

require 'aws-sdk-s3'

module ActiveIntelligence
  module Concerns
    module S3
      extend ActiveSupport::Concern

      included do
        def s3_client
          @s3_client ||= ::Aws::S3::Client.new(
            region: settings[:region],
            access_key_id: settings[:access_key_id],
            secret_access_key: settings[:secret_access_key]
          )
        end

        def s3_download(key)
          response = s3_client.get_object(
            bucket: settings[:bucket],
            key: s3_path(key)
          )

          return response.body.string
        end

        def s3_upload(file, key)
          s3_client.put_object(
            bucket: settings[:bucket],
            key: s3_path(key),
            body: File.open(file, 'rb')
          )
        end

        def s3_path(key)
          [settings[:folder], key].compact.join('/')
        end

        def s3_url(key)
          "s3://#{settings[:bucket]}/#{s3_path(key)}"
        end
      end
    end
  end
end
