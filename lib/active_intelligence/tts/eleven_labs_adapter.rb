# frozen_string_literal: true

require 'elevenlabs/client'

module ActiveIntelligence
  module TTS
    class ElevenLabsAdapter < Adapter

      def generate(text, options = {})
        voice_id = config(:voice_id, options)
        stability = config(:stability, options, 0.5)
        return client.text_to_speech(voice_id:, text:, stability:)
      end

      #########################################################################
      # private

      def client
        @client ||= Elevenlabs::Client.new(api_key: settings[:api_key])
      end
    end
  end
end
