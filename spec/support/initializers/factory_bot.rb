# frozen_string_literal: true

# SEE: https://github.com/thoughtbot/factory_bot/wiki/Integration%3A-RSpec

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
end

# SEE: https://www.hocnest.com/blog/testing-an-engine-with-rspec/

FactoryBot.definition_file_paths << ActiveIntelligence::Engine.root.join('spec/factories')
FactoryBot.factories.clear
FactoryBot.find_definitions
