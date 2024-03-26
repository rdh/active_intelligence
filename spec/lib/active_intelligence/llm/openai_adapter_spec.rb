# frozen_string_literal: true

describe ActiveIntelligence::LLM::OpenAIAdapter do

  it 'is an ActiveIntelligence::LLM::Adapter' do
    expect(described_class).to be < ActiveIntelligence::Adapter
  end
end
