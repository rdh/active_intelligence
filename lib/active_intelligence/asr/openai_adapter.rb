# frozen_string_literal: true

require 'openai'

module ActiveIntelligence
  module ASR
    class OpenAIAdapter < Adapter
      include ActiveIntelligence::Concerns::OpenAI

      def transcribe(path, options = {})
        parameters = default_parameters.merge(options)
        parameters[:file] = File.open(path, 'rb')

        response = client.audio.transcribe(parameters:)
        return response['text']
      end
    end
  end
end
