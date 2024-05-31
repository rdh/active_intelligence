# frozen_string_literal: true

describe ActiveIntelligence::TTS::MockAdapter do

  let(:adapter) { described_class.new(path:) }
  let(:path) { 'spec/data/audio/mock.mp3' }
  let(:text) { 'Hello darkness, my old friend' }

  it 'is an ActiveIntelligence::TTS::Adapter' do
    expect(described_class).to be < ActiveIntelligence::TTS::Adapter
  end

  describe '#transcribe' do

    subject { adapter.generate(text) }

    let(:expected) { File.open(path).read }

    it 'returns the contents of the configured path' do
      expect(subject).to eql(expected)
    end
  end
end
