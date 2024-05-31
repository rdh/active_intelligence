# frozen_string_literal: true

describe ActiveIntelligence::ASR::MockAdapter do

  let(:adapter) { described_class.new }
  let(:path) { 'spec/data/audio/ebn.wav' }

  it 'is an ActiveIntelligence::ASR::Adapter' do
    expect(described_class).to be < ActiveIntelligence::ASR::Adapter
  end

  describe '#transcribe' do

    subject { adapter.transcribe(path) }

    it 'returns a string' do
      expect(subject).to be_a(String)
    end
  end
end
