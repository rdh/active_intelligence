# frozen_string_literal: true

module ActiveIntelligence
  class Config

    def adapter(key = Rails.env.to_sym)
      settings = settings(key)

      klass = [
        'ActiveIntelligence',
        name,
        settings[:adapter].to_s.camelize
      ].join('::').constantize

      return klass.new(settings)
    end

    def file
      File.read(Rails.root.join(path))
    end

    def name
      self.class.name.split('::')[1]
    end

    def path
      "config/ai/#{name.downcase}.yml"
    end

    def settings(key = Rails.env.to_sym)
      settings = yaml[key]
      raise KeyError, "#{path}: #{key}" unless settings

      return settings
    end

    def yaml
      return @yaml if @yaml

      erb = ERB.new(file).result
      yaml = YAML.safe_load(erb, aliases: true)
      @yaml = yaml.deep_symbolize_keys

      return @yaml
    end
  end
end
