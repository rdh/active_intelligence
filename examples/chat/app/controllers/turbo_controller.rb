class TurboController < ApplicationController
  include ActiveIntelligence

  def index
    @chat = Chat.create!
  end

  def update
    @message = chat.messages.create!(role: 'user', content: params[:content])

    append_message(@message)
    with_loading_bubble { @reply = chat.reply }
    append_message(@reply)

    head :no_content
  end

  #############################################################################
  # Helpers

  def append_message(message)
    append_partial(message, 'turbo/message')
  end

  def append_partial(message, partial)
    stream.broadcast_append_to(chat,
                               target:,
                               partial:,
                               locals: { message: })
  end

  def with_loading_bubble
    stream.broadcast_append_to(chat, target:, partial: 'turbo/loading')
    yield
    stream.broadcast_remove_to(chat, target: 'loading-bubble')
  end

  #############################################################################
  # Accessors

  def chat
    @chat ||= Chat.find(params[:id])
  end

  def stream
    Turbo::StreamsChannel
  end

  def target
    'messages'
  end
end
