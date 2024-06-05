class Chapter < ApplicationRecord
  belongs_to :book
  has_many :paragraphs, dependent: :destroy

  def import
    number = 0
    buffer = []

    lines.each do |line|
      if line.empty?
        paragraphs.create!(number: number += 1, content: buffer.join("\n"))
        buffer.clear
      else
        buffer << line
      end
    end
  end

  def lines
    @lines ||= book.lines[start_line..end_line]
  end
end
