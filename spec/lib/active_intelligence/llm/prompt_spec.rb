# frozen_string_literal: true

describe ActiveIntelligence::LLM::Prompt do

  describe '.render' do
    it 'returns a string' do
      expect(described_class.render).to eq('SUCCESS')
    end
  end
end

