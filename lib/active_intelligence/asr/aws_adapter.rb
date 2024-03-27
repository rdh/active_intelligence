# frozen_string_literal: true

require 'aws-sdk-s3'

module ActiveIntelligence
  module ASR
    class AwsAdapter < Adapter

      def transcribe(file, options = {})
        # parameters = default_parameters.merge(options)
        # parameters[:file] = File.open(file, 'rb')
        #
        # response = client.audio.transcribe(parameters:)
        # return response['text']
      end

      def s3_client
        @s3_client ||= ::Aws::S3::Client.new(
          region: settings[:region],
          access_key_id: settings[:access_key_id],
          secret_access_key: settings[:secret_access_key]
        )
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
        "https://#{settings[:bucket]}/#{s3_path(key)}"
      end
    end
  end
end
