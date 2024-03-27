# frozen_string_literal: true

class RootController < ApplicationController
  def index
    @settings = adapter.settings
    @prompt = params[:prompt]
    return unless request.post? && @prompt.present?

    puts 'Calling LLM'
    @generated = adapter.generate(@prompt)
    puts "Generated: #{@generated}"
  end

  def adapter
    @adapter ||= ActiveIntelligence::LLM::Config.new.adapter
  end
end
