# frozen_string_literal: true

# SEE: https://github.com/thoughtbot/factory_bot/wiki/Integration%3A-RSpec

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
end
