# frozen_string_literal: true

describe ActiveIntelligence::Adapter do

  describe 'initialize' do
    subject { described_class.new(settings) }

    let(:settings) { { foo: 'bar' } }

    it 'initializes settings' do
      expect(subject.settings).to eq(settings)
    end
  end
end
