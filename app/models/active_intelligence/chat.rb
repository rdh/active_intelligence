# frozen_string_literal: true

module ActiveIntelligence
  class Chat < ApplicationRecord

    has_many :messages,
             class_name: ActiveIntelligence::ChatMessage.to_s,
             dependent: :destroy,
             counter_cache: :messages_count
  end
end
