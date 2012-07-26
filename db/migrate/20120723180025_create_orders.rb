class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :street_address
      t.string :state
      t.string :city
      t.string :country
      t.integer :zipcode
      t.integer :customer_id
      t.integer :price

      t.timestamps
    end
  end
end
