class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.integer :type
      t.string :desc
      t.string :options
      t.string :display_text
      t.decimal :price
      t.string :sku
      t.references :user
      t.attachment :image
      t.timestamps
    end
    add_index :items, :user_id
  end
end
