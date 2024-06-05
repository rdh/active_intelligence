class Paragraph < ApplicationRecord
  include ActiveIntelligence::Embeddable

  belongs_to :chapter

  def import!
    chapter.paragraphs.create!(content:)
    add_embedding(content)
  end
end
