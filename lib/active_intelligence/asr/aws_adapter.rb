# frozen_string_literal: true


require 'aws-sdk-transcribeservice'

module ActiveIntelligence
  module ASR
    class AwsAdapter < Adapter
      include ActiveIntelligence::Concerns::Aws
      include ActiveIntelligence::Concerns::S3

      class TranscriptionFailed < StandardError; end

      def transcribe(path, options = {})
        raw = options.delete(:raw)

        key = upload(path)
        job = start(key, options)
        info = wait(job)
        json = download(info)

        return raw ? json : json[:results][:transcripts].first[:transcript]
      end

      #########################################################################
      # private

      def client
        @client ||= Aws::TranscribeService::Client.new(
          region: settings[:region],
          access_key_id: settings[:access_key_id],
          secret_access_key: settings[:secret_access_key]
        )
      end

      def default_parameters
        super.except(:sleep)
      end

      def download(info)
        url = info.transcription_job.transcript.transcript_file_uri
        transcript = s3_download(key(url))
        return JSON.parse(transcript, symbolize_names: true)
      end

      def format(path)
        File.extname(path).delete_prefix('.')
      end

      def info(job)
        client.get_transcription_job(transcription_job_name: job)
      end

      def key(path)
        File.basename(path)
      end

      def parameters(key)
        {
          transcription_job_name: "transcribe-#{Time.now.to_i}",
          language_code: 'en-US',
          media_format: format(key),
          media: { media_file_uri: s3_url(key) },
          output_bucket_name: settings[:bucket],
          output_key: s3_path("transcribe-#{Time.now.to_i}.json")
        }
      end

      def start(key, options = {})
        parameters = parameters(key).deep_merge(options)
        client.start_transcription_job(parameters)

        job = parameters[:transcription_job_name]
        Rails.logger.debug("AwsAdapter#start, job=#{job}")

        return job
      end

      def status(info)
        info.transcription_job.transcription_job_status
      end

      def upload(path)
        key = key(path)
        s3_upload(path, key)
        return key
      end

      def wait(job)
        loop do
          info = info(job)
          Rails.logger.debug("AwsAdapter#wait, job=#{job}, status=#{status(info)}")

          case status(info)
            when 'COMPLETED' then return info
            when 'FAILED' then raise TranscriptionFailed, info
          end

          sleep settings[:sleep] || 60
        end
      end
    end
  end
end
