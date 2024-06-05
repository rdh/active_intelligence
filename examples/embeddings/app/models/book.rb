class Book < ApplicationRecord
  has_many :chapters, dependent: :destroy

  def import
    chapters.each(&:import)
  end

  def lines
    @lines ||= File.readlines(path).map(&:strip)
  end
end
