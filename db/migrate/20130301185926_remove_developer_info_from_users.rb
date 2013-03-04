class RemoveDeveloperInfoFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :api_key
    remove_column :users, :merchant_name
  end

  def down
    add_column :users, :merchant_name, :string
    add_column :users, :api_key, :string
  end
end
