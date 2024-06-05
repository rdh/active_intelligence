# frozen_string_literal: true

module ApplicationHelper
  def bold_query(text, query)
    # rubocop:disable Rails/OutputSafety
    text.gsub(/#{query}/i) { |s| "<b>#{s}</b>" }.html_safe
    # rubocop:enable Rails/OutputSafety
  end
end
