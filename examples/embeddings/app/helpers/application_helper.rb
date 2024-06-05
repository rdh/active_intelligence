module ApplicationHelper
  def bold_query(text, query)
    text.gsub(/#{query}/i) { |s| "<b>#{s}</b>" }.html_safe
  end
end
