# frozen_string_literal: true

# rubocop:disable Rails/RakeEnvironment

namespace :rubocop do

  desc 'Auto-correct current Rubocop offenses'
  task :fix do
    exec('rubocop -A')
  end

  desc 'Accept current Rubocop offenses'
  task :ok do
    exec('rubocop --auto-gen-config')
  end
end

# rubocop:enable Rails/RakeEnvironment
