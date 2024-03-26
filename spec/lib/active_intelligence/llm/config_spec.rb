# frozen_string_literal: true

describe ActiveIntelligence::LLM::Config do

  ###############################################################################
  # .adapter

  describe '.adapter' do
    subject { described_class.adapter }

    let(:expected) { ActiveIntelligence::LLM::Base }

    it('returns an adapter') { expect(subject).to be_a_kind_of(expected) }

    context 'with an invalid '
  end

  ###############################################################################
  # .path

  describe '.path' do
    subject { described_class.path }

    let(:expected) { Rails.root.join('config/ai/llm.yml') }

    it('returns a path') { expect(subject).to eq(expected) }
  end

  ###############################################################################
  # .settings

  describe '.settings' do
    subject { described_class.settings(key) }

    let(:yaml) {  described_class.yaml }

    context 'with a valid key' do
      let(:key) { :test }

      it('returns a hash') { expect(subject).to be_a(Hash) }
      it('returns values from yaml') { expect(subject).to eq(yaml[key]) }
    end

    context 'with an invalid key' do
      let(:key) { :invalid }

      it('raises KeyError') { expect { subject }.to raise_error(KeyError) }
    end

    context 'with no key provided' do
      subject { described_class.settings }

      it('returns a hash') { expect(subject).to be_a(Hash) }
      it('returns values from yaml') { expect(subject).to eq(yaml[:test]) }
    end
  end

  ###############################################################################
  # .yaml

  describe '.yaml' do
    subject { described_class.yaml }

    it('returns a hash') { expect(subject).to be_a(Hash) }
  end
end
