# frozen_string_literal: true

require_relative 'lib/active_intelligence/version'

Gem::Specification.new do |spec|
  spec.name        = 'active_intelligence'
  spec.version     = ActiveIntelligence::VERSION
  spec.authors     = ['Rich Humphrey']
  spec.email       = ['rdh727@gmail.com']
  spec.homepage    = 'https://github.com/rdh/active_intelligence'
  spec.summary     = 'AI on Rails'
  spec.description = 'Rails engine for AI tasks'
  spec.license     = 'MIT'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/rdh/active_intelligence'
  spec.metadata['changelog_uri'] = 'https://github.com/rdh/active_intelligence/blob/main/CHANGELOG.md'

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']
  end

  spec.add_dependency 'rails', '>= 7.1.3'

  spec.add_dependency 'require_all'
end
