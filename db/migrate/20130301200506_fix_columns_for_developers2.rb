class FixColumnsForDevelopers2 < ActiveRecord::Migration
  def up
  	rename_column :developers, :api_key_temp, :api_key
  	rename_column :developers, :merchant_name_temp, :merchant_name
  end

  def down
  end
end
