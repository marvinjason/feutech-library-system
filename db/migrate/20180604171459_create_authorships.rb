class CreateAuthorships < ActiveRecord::Migration[5.1]
  def change
    create_table :authorships do |t|
      t.belongs_to :book, foreign_key: true
      t.belongs_to :author, foreign_key: true

      t.timestamps
    end
  end
end
