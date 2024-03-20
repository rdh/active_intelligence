# frozen_string_literal: true

###############################################################################
# Test Class

module ActiveIntelligence
  class TestPromptable
    include ActiveIntelligence::Promptable

    attr_reader :name

    def initialize(name)
      @name = name
    end
  end
end

describe ActiveIntelligence::Promptable do

  ###############################################################################
  # #to_prompt

  describe '#to_prompt' do
    subject { ActiveIntelligence::TestPromptable.new(name).to_prompt(name) }

    context 'without a name' do
      let(:name) { nil }

      it('returns a string') { expect(subject).to be_a(String) }
      it('renders the ERB') { expect(subject).to match(/default prompt/) }
    end

    context 'with a name' do
      let(:name) { :test }

      it('returns a string') { expect(subject).to be_a(String) }
      it('renders the ERB') { expect(subject).to match(/prompt named "test"/) }
    end
  end
end
