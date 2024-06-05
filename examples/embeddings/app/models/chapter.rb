# frozen_string_literal: true

class Chapter < ApplicationRecord
  belongs_to :book
  has_many :paragraphs, dependent: :destroy

  def import!(&block)
    buffer = Buffer.new(paragraphs)

    lines.each do |line|
      line.empty? ? buffer.flush(&block) : buffer << line
    end
  end

  def lines
    @lines ||= book.lines[start_line..end_line]
  end

  #############################################################################
  # Buffer

  class Buffer
    attr_reader :lines, :paragraphs

    delegate :<<, to: :lines

    def initialize(paragraphs)
      @lines = []
      @number = 0
      @paragraphs = paragraphs
    end

    def flush
      content = lines.join("\n")
      return if content.empty?

      paragraphs.create!(number: @number += 1, content:).import!
      @lines = []

      yield if block_given?
    end
  end
end
