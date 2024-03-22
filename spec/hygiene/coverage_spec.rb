# frozen_string_literal: true

describe 'coverage' do

  let(:engine_root) { Rails.root.join('../..') }

  it 'has a spec for every file' do
    %w[app lib].each do |dir|
      target = engine_root.join(dir, '**/*.{rb,erb,rake}')
      Dir.glob(target) do |path|
        next if File.basename(path).match?(/^_/)

        expect(path.sub!(%r{#{engine_root}/}, '')).to have_a_spec
      end
    end
  end
end

###############################################################################
# have_a_spec Matcher

RSpec::Matchers.define :have_a_spec do

  description do
    'has a spec file'
  end

  match do |path|
    File.exist?(spec_file_for(path))
  end

  failure_message do |path|
    "expected #{path} to have spec at #{spec_file_for(path)}"
  end

  failure_message_when_negated do |path|
    "expected #{path} to not have spec at #{spec_file_for(path)}"
  end

  def spec_file_for(path)
    basename = File.basename(path, '.rb')
    spec = "#{basename}_spec.rb"

    dirname = File.dirname(path)
    dirname.gsub!(/^app/, 'spec')
    dirname.gsub!(/^lib/, 'spec/lib')

    return File.join(dirname, spec)
  end
end
