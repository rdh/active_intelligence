# frozen_string_literal: true

module ActiveIntelligence
  module LLM
    class Config

      def self.adapter(key = Rails.env.to_sym)
        settings = settings(key)

        klass = [
          'ActiveIntelligence::LLM',
          settings[:adapter].to_s.camelize
        ].join('::').constantize
        return klass.new(settings)
      end

      def self.file
        File.read(path)
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
        return @yaml if @yaml

        erb = ERB.new(file).result
        yaml = YAML.safe_load(erb, aliases: true)
        return @yaml = yaml.deep_symbolize_keys
      end
    end
  end
end
