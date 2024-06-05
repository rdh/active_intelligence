# frozen_string_literal: true

class Chapter < ApplicationRecord
  belongs_to :book
  has_many :paragraphs, dependent: :destroy

  def import!
    buffer = Buffer.new

    lines.each do |line|
      if line.empty?
        buffer.flush
      else
        buffer << line
      end
    end
  end

  def lines
    @lines ||= book.lines[start_line..end_line]
  end

  class Buffer
    def initialize(paragraphs)
      @buffer = []
      @number = 0
      @paragraphs = paragraphs
    end

    def <<(line)
      @buffer << line
    end

    def flush
      content = @buffer.join("\n")
      return if content.empty?

      paragraphs.create!(number: @number += 1, content:).import!
      @buffer = []
    end
  end
end
