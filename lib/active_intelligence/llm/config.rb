# frozen_string_literal: true

module ActiveIntelligence
  module LLM
    class Config

      # TODO: Move to BaseAdapter
      def self.adapter(key = Rails.env.to_sym)
        settings = settings(key)

        klass = [
          'ActiveIntelligence::LLM',
          [settings[:llm].to_s.camelize, 'LLM'].join
        ].join('::').constantize
        return klass.new(settings)
      end

      def self.path
        Rails.root.join('config/llm.yml')
      end

      def self.settings(key = Rails.env.to_sym)
        settings = yaml[key]
        raise KeyError, "config/llm.yml: #{key}" unless settings

        return settings
      end

      def self.yaml
        @yaml ||= YAML.load_file(path).deep_symbolize_keys
      end
    end
  end
end
