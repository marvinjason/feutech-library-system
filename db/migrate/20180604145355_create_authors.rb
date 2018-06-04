class CreateAuthors < ActiveRecord::Migration[5.1]
  def change
    create_table :authors do |t|
      t.string :last_name
      t.string :first_name
      t.text :description
      t.string :avatar

      t.timestamps
    end
  end
end
