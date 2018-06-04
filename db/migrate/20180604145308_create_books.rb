class CreateBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :books do |t|
      t.string :title
      t.belongs_to :publisher, foreign_key: true
      t.string :publication_address
      t.integer :publication_year
      t.text :description
      t.string :edition
      t.string :series
      t.string :isbn
      t.string :call_number
      t.string :language
      t.integer :page_count
      t.string :book_format
      t.string :cover
      t.integer :total_count

      t.timestamps
    end
  end
end
