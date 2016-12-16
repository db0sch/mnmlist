class AddNamesTablesForUsers < ActiveRecord::Migration[5.0]
  def change
    rename_column :users, :name, :first_name
    add_column :users, :last_name, :string
    add_column :users, :username, :string
  end
end
