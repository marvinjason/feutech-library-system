class CreateReservations < ActiveRecord::Migration[5.1]
  def change
    create_table :reservations do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :book, foreign_key: true
      t.datetime :start
      t.datetime :end
      t.string :status

      t.timestamps
    end
  end
end
