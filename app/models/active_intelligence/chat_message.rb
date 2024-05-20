# frozen_string_literal: true

module ActiveIntelligence
  class ChatMessage < ApplicationRecord

    belongs_to :chat,
               class_name: ActiveIntelligence::Chat.to_s,
               counter_cache: :messages_count

    enum role: { assistant: 0, user: 1 }
  end
end
