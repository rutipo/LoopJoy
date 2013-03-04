class FixUserIdForItems < ActiveRecord::Migration
  def up
  	rename_column :items, :user_id, :developer_id
  end

  def down
  end
end
