class CreateChapters < ActiveRecord::Migration[7.1]
  def change
    create_table :chapters do |t|
      t.references :book, null: false
      t.string :title
      t.integer :number
      t.integer :start_line
      t.integer :end_line
      t.timestamps
    end
  end
end
