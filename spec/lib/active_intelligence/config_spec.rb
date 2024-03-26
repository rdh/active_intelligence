# frozen_string_literal: true

module ActiveIntelligence
  module Test
    class Config < ActiveIntelligence::Config; end
    class TestAdapter < ActiveIntelligence::Adapter; end
  end
end

describe ActiveIntelligence::Config do

  let(:config) { ActiveIntelligence::Test::Config.new }

  ###############################################################################
  # adapter

  describe '#adapter' do
    subject { config.adapter(key) }

    context 'with a valid key' do
      let(:key) { :test }

      it 'returns an adapter' do
        expect(subject).to be_a(ActiveIntelligence::Test::TestAdapter)
      end
    end

    context 'with an invalid key' do
      let(:key) { :invalid }

      it('raises KeyError') { expect { subject }.to raise_error(KeyError) }
    end

    context 'with a bogus adapter' do
      let(:key) { :bogus }

      it('raises NameError') { expect { subject }.to raise_error(NameError) }
    end

    context 'with no key provided' do
      subject { config.adapter }

      let(:expected) { config.settings }

      it 'returns the default adapter' do
        expect(subject).to be_a(ActiveIntelligence::Test::TestAdapter)
        expect(subject.settings).to eq(expected)
      end
    end
  end

  ###############################################################################
  # file

  describe '#file' do
    subject { config.file }

    let(:path) { Rails.root.join(config.path) }
    let(:expected) { File.read(path) }

    it 'returns a string' do
      expect(subject).to be_a(String)
      expect(subject).to eq(expected)
    end
  end

  ###############################################################################
  # name

  describe '#name' do
    subject { config.name }

    it 'returns a string' do
      expect(subject).to be_a(String)
      expect(subject).to eq('Test')
    end
  end

  ###############################################################################
  # path

  describe '#path' do
    subject { config.path }

    it 'returns a string' do
      expect(subject).to be_a(String)
      expect(subject).to eq('config/ai/test.yml')
    end
  end

  ###############################################################################
  # settings

  describe '#settings' do
    subject { config.settings(key) }

    let(:yaml) { config.yaml }

    context 'with a valid key' do
      let(:key) { :development }

      it('returns a hash') { expect(subject).to be_a(Hash) }
      it('returns values from yaml') { expect(subject).to eq(yaml[key]) }
    end

    context 'with an invalid key' do
      let(:key) { :invalid }

      it('raises KeyError') { expect { subject }.to raise_error(KeyError) }
    end

    context 'with no key provided' do
      subject { config.settings }

      it('returns a hash') { expect(subject).to be_a(Hash) }
      it('returns values from yaml') { expect(subject).to eq(yaml[:test]) }
    end
  end

  ###############################################################################
  # yaml

  describe '#yaml' do
    subject { config.yaml }

    it 'returns a hash' do
      expect(subject).to be_a(Hash)
      expect(subject[:test][:adapter]).to eq('test')
    end
  end
end
