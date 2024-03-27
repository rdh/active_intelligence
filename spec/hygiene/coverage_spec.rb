# frozen_string_literal: true

describe 'coverage' do

  let(:directories) { %w[app lib] }
  let(:root) { Rails.root.join('../..') }

  it 'has a spec for every file' do
    missing = files.reject { |path| spec_exists?(path) }
    missing.each { |path| puts "Missing spec: #{path}" }
    expect(missing).to be_empty
  end

  def files
    files = directories.map { |dir| Dir.glob(root.join(dir, '**/*.{rb,erb,rake}')) }
    files = files.flatten.reject { |path| File.basename(path).match?(/^_/) }
    return files.map { |path| path.sub!(%r{#{root}/}, '') }
  end

  def spec_exists?(path)
    basename = File.basename(path, '.rb')
    spec = "#{basename}_spec.rb"

    dirname = File.dirname(path)
    dirname.gsub!(/^app/, 'spec')
    dirname.gsub!(/^lib/, 'spec/lib')

    spec = File.join(dirname, spec)
    return File.exist?(spec)
  end
end
