class RemoveDeveloperIdFromUser < ActiveRecord::Migration
  def up
    remove_column :users, :developer_id
  end

  def down
    add_column :users, :developer_id, :string
  end
end
