class AddRoleToUsers < ActiveRecord::Migration
  def change
    add_column :users, :role, :string
    add_column :users, :name, :string
    add_column :users, :merchant_name, :string
    add_column :users, :developer_id, :string
    add_column :users, :api_key, :string
  end
end