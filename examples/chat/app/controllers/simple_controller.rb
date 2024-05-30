class SimpleController < ApplicationController
  include ActiveIntelligence

  def index
    @chat = Chat.create!
  end

  def update
    @chat = Chat.find(params[:id])
    @chat.messages.create!(role: 'user', content: params[:content])
    @chat.reply

    render :index
  end
end
