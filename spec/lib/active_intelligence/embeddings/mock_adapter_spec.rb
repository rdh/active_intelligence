# frozen_string_literal: true

describe ActiveIntelligence::Embeddings::MockAdapter do

  let(:adapter) { described_class.new }
  let(:text) { 'Hello darkness, my old friend.' }

  it 'is an ActiveIntelligence::Embeddings::Adapter' do
    expect(described_class).to be < ActiveIntelligence::Embeddings::Adapter
  end

  describe '#generate' do

    subject { adapter.generate(text) }

    it 'returns an array' do
      expect(subject).to be_a(Array)
    end
  end
end
