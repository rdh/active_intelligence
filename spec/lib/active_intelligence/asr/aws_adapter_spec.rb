# frozen_string_literal: true

describe ActiveIntelligence::ASR::AwsAdapter do

  it 'is an ActiveIntelligence::ASR::Adapter' do
    expect(described_class).to be < ActiveIntelligence::Adapter
  end
end
