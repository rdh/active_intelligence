class CreateParagraphs < ActiveRecord::Migration[7.1]
  def change
    create_table :paragraphs do |t|
      t.references :chapter, null: false, foreign_key: true
      t.integer :number
      t.text :content
      t.timestamps
    end
  end
end
