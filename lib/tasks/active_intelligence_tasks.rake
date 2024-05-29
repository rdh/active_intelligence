# frozen_string_literal: true

namespace :active_intelligence do
  include ActiveIntelligence

  desc 'Chat with the LLM'
  task :chat, [:id] => :environment do |_t, args|
    chat = args[:id].nil? ? Chat.create! : Chat.find(args[:id])
    ChatREPLService.call(chat)
  end

  task :asr, [:path] => :environment do |_t, args|

  end
end
