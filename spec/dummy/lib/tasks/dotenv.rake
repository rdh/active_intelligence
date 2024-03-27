# frozen_string_literal: true

# rubocop:disable Rails/RakeEnvironment

namespace :dotenv do

  desc 'Update all dotenv templates'
  task :template do
    %w[
      examples/asr
      examples/llm
      spec/dummy
    ].each do |dir|
      Dir.chdir(dir) do
        system('dotenv -t .env')
      end
    end
  end
end

# rubocop:enable Rails/RakeEnvironment
