class CreateLogs < ActiveRecord::Migration[5.1]
  def change
    create_table :logs do |t|
      t.references :logable, polymorphic: true
      t.string :log_type
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
  end
end
