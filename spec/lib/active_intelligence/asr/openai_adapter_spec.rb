# frozen_string_literal: true

describe ActiveIntelligence::ASR::OpenAIAdapter do

  it 'is an ActiveIntelligence::ASR::Adapter' do
    expect(described_class).to be < ActiveIntelligence::Adapter
  end
end
