class DropTypeFromItems < ActiveRecord::Migration
  def up
  	    remove_column :items, :type
  	    add_column :items, :item_type, :integer
  end

  def down
  end
end
