# frozen_string_literal: true

module ActiveIntelligence
  class ChatREPLService < ApplicationService
    # rubocop:disable Rails/Output

    def initialize(chat)
      super

      @chat = chat
      @counter = 1
    end

    def call
      header
      help
      history
      loop { cycle || break }
    end

    def cycle
      print prefix(:user)
      input = $stdin.gets.chomp
      case input
        when 'h' then help
        when 'p' then prompt
        when 'q' then return false
        else reply(input)
      end

      return true
    end

    def header
      puts "Chat #{@chat.id}\n"
    end

    def help
      puts <<~HELP

        h - help
        p - prompt
        q - quit
      HELP
    end

    def history
      @chat.messages.order(:id).each do |message|
        @counter += 1
        puts [prefix(message.role), message.content].join
      end
    end

    def prefix(name)
      "\n(#{name}:#{@counter})> "
    end

    def prompt
      puts ["\n", @chat.to_prompt].join
    end

    def reply(input)
      @chat.messages.create!(role: 'user', content: input)

      @counter += 1
      print prefix(:assistant)
      puts @chat.reply.content
      @counter += 1
    end

    # rubocop:enable Rails/Output
  end
end
