class CreateDevelopers < ActiveRecord::Migration
  def change
    create_table :developers do |t|
      t.string :name
      t.string :email
      t.string :apiKey
      t.string :paypal_email
      t.string :merchant_name

      t.timestamps
    end
  end
end
