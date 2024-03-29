# frozen_string_literal: true

describe ActiveIntelligence::ASR::AwsAdapter do

  it 'is an ActiveIntelligence::ASR::Adapter' do
    expect(described_class).to be < ActiveIntelligence::Adapter
  end

  it 'needs specs'

  describe 'ActiveIntelligence::ASR::AwsAdapter::Diarizer#lines' do
    subject { ActiveIntelligence::ASR::AwsAdapter::Diarizer.new(json).lines }

    let(:json) { JSON.parse(File.read(path), symbolize_names: true) }
    let(:path) { 'spec/data/audio/podcast/aws_diarization.json' }

    it 'returns am array of strings' do
      expect(subject).to be_an(Array)
      expect(subject).to all(be_a(String))
    end
  end
end
