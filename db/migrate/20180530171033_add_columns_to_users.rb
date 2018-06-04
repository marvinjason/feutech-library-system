class AddColumnsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :last_name, :string
    add_column :users, :first_name, :string
    add_column :users, :contact_number, :string
    add_column :users, :address, :string
    add_column :users, :role, :string, default: 'user'
    add_column :users, :provider, :string
    add_column :users, :uid, :string
    add_column :users, :avatar, :string
  end
end
