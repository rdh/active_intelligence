# frozen_string_literal: true

class Book < ApplicationRecord
  has_many :chapters, dependent: :destroy

  def import!(&block)
    chapters.each { |chapter| chapter.import!(&block) }
  end

  def lines
    @lines ||= File.readlines(path).map(&:strip)
  end
end
