# frozen_string_literal: true

class Paragraph < ApplicationRecord
  include ActiveIntelligence::Embeddable

  belongs_to :chapter

  def import!
    add_embedding(content)
  end
end
