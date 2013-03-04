class RemoveEmailFromDevelopers < ActiveRecord::Migration
  def up
    remove_column :developers, :email
  end

  def down
    add_column :developers, :email, :string
  end
end
