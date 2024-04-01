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

      def diarize(path, options = {})
        json = transcribe(path, options.merge(raw: true))
        return Diarizer.new(json).lines.join("\n")
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

      def parameters(key, options)
        now = Time.now.to_i
        format = options.delete(:format) # TODO: This ain't good

        parameters = {
          transcription_job_name: "transcribe-#{now}",
          language_code: settings[:language_code] || 'en-US',
          media_format: format || format(key),
          media: { media_file_uri: s3_url(key) },
          output_bucket_name: settings[:bucket],
          output_key: s3_path("transcribe-#{now}.json")
        }

        return default_parameters.deep_merge(parameters).deep_merge(options)
      end

      def start(key, options)
        parameters = parameters(key, options)
        client.start_transcription_job(parameters)

        job = parameters[:transcription_job_name]
        logger.debug("AwsAdapter#start: job=#{job}")

        return job
      end

      def status(info)
        info.transcription_job.transcription_job_status
      end

      def upload(path)
        key = key(path)
        s3_upload(path, key)
        logger.debug("AwsAdapter#upload: path=#{path}, key=#{key}")

        return key
      end

      def wait(job)
        loop do
          info = info(job)
          logger.debug("AwsAdapter#wait: job=#{job}, status=#{status(info)}")

          case status(info)
            when 'COMPLETED' then return info
            when 'FAILED' then raise TranscriptionFailed, info
          end

          sleep settings[:sleep] || 60
        end
      end

      #########################################################################
      # Diarizer

      class Diarizer
        def initialize(json)
          @json = json

          @line = nil
          @lines = nil
          @speaker = nil
          @starts = nil
        end

        def lines
          return @lines if @lines

          @lines = []
          items.each { |item| process(item) }
          @lines << @line.join(' ') if @line

          return @lines
        end

        def process(item)
          content = item[:alternatives].first[:content]
          process_speaker(item) unless item[:type] == 'punctuation'
          @line << content
        end

        def process_speaker(item)
          speaker = starts[item[:start_time]]
          return if speaker == @speaker

          @lines << @line.join(' ') if @line

          @speaker = speaker
          @line = ["#{@speaker}:"]
        end

        def starts
          return @starts if @starts

          @starts = {}
          segments.each do |segment|
            speaker = segment[:speaker_label]

            segment[:items].each do |item|
              starts[item[:start_time]] = speaker
            end
          end

          return @starts
        end

        #######################################################################
        # Accessors

        def items
          @json[:results][:items]
        end

        def segments
          @json[:results][:speaker_labels][:segments]
        end
      end
    end
  end
end
