# frozen_string_literal: true

class RootController < ApplicationController
  def index
    @paragraphs = []
    return if query.blank?

    @paragraphs = Paragraph.semantic_search(query)
  end

  def query
    @query = params[:query]
  end
end
