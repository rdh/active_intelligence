# frozen_string_literal: true

describe ActiveIntelligence::LLM::MockAdapter do

  let(:adapter) { described_class.new }
  let(:prompt) { 'Hello darkness, my old friend.' }
  let(:chat) { build(:chat) }

  it 'is an ActiveIntelligence::LLM::Adapter' do
    expect(described_class).to be < ActiveIntelligence::LLM::Adapter
  end

  describe '#generate' do

    subject { adapter.generate(prompt) }

    it 'returns a string' do
      expect(subject).to be_a(String)
    end
  end

  describe '#reply' do

    subject { adapter.reply(chat, prompt) }

    it 'returns a string' do
      expect(subject).to be_a(String)
    end
  end
end
