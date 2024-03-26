# frozen_string_literal: true

describe ActiveIntelligence::ASR::Config do

  it 'is an ActiveIntelligence::Config' do
    expect(described_class).to be < ActiveIntelligence::Config
  end
end
