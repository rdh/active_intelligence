# frozen_string_literal: true

FactoryBot.define do
  factory :chat_message, class: ActiveIntelligence::ChatMessage.to_s do
    chat
    role { 'assistant' }
    sequence(:content) { |n| "This is test message #{n}" }
  end
end
