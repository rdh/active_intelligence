# This migration comes from active_intelligence (originally 20240603225528)
class EnableVector < ActiveRecord::Migration[7.1]
  def change
    enable_extension "vector"
  end
end
