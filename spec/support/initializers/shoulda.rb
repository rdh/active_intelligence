# SEE: https://github.com/thoughtbot/shoulda-matchers?tab=readme-ov-file#rspec

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end
