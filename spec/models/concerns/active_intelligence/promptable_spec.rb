# frozen_string_literal: true

###############################################################################
# Test Class

module ActiveIntelligence
  class TestPromptable
    include ActiveIntelligence::Promptable

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

  ###############################################################################
  # .prompt_directory

  describe '.prompt_directory' do
    subject { ActiveIntelligence::TestPromptable.prompt_directory }

    let(:expected) { Rails.root.join('app/prompts') }

    it('returns a path') { expect(subject).to eq(expected) }
  end

  ###############################################################################
  # .prompt_file

  describe '.prompt_file' do
    subject { ActiveIntelligence::TestPromptable.prompt_file(nil) }

    let(:expected) { File.read(ActiveIntelligence::TestPromptable.prompt_path(nil)) }

    it('returns a string') { expect(subject).to eq(expected) }
  end

  ###############################################################################
  # .prompt_path

  describe '.prompt_path' do

    context 'without a name' do
      subject { ActiveIntelligence::TestPromptable.prompt_path(nil) }

      let(:expected) { Rails.root.join('app/prompts/active_intelligence/test_promptables.erb') }

      it('returns a path') { expect(subject).to eq(expected) }
    end

    context 'with a name' do
      subject { ActiveIntelligence::TestPromptable.prompt_path(:test) }

      let(:expected) { Rails.root.join('app/prompts/active_intelligence/test_promptables/test.erb') }

      it('returns a path') { expect(subject).to eq(expected) }
    end
  end
end
