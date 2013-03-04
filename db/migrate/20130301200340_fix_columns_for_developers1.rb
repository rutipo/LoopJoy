class FixColumnsForDevelopers1 < ActiveRecord::Migration
  def up
  	rename_column :developers, :api_key, :merchant_name_temp
  	rename_column :developers, :merchant_name, :api_key_temp
  end

  def down
  end
end
