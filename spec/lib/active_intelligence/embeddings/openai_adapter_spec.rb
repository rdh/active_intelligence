# frozen_string_literal: true

describe ActiveIntelligence::Embeddings::OpenAIAdapter do

  it 'is an ActiveIntelligence::Embeddings::Adapter' do
    expect(described_class).to be < ActiveIntelligence::Embeddings::Adapter
  end

  it 'needs specs'
end
