class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.integer :type
      t.string :desc
      t.string :options
      t.string :display_text
      t.decimal :price, :precision => 8, :scale => 2
      t.string :sku
      t.has_attached_file :image
      t.references :developer

      t.timestamps
    end
    add_index :items, :developer_id
  end
end
