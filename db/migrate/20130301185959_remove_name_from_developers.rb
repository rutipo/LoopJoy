class RemoveNameFromDevelopers < ActiveRecord::Migration
  def up
    remove_column :developers, :name
  end

  def down
    add_column :developers, :name, :string
  end
end
