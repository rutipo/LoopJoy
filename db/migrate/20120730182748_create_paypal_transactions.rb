class CreatePaypalTransactions < ActiveRecord::Migration
  def change
    create_table :paypal_transactions do |t|
      t.string :address_city
      t.string :address_country
      t.string :address_country_code
      t.string :address_street
      t.string :address_state
      t.integer :address_zip
      t.string :first_name
      t.string :last_name
      t.string :payer_email
      t.string :payer_id
      t.string :contact_phone
      t.string :residence_country
      t.string :item_name
      t.integer :item_number
      t.integer :quantity
      t.string :custom
      t.string :memo
      t.string :txn_id
      t.string :txn_type
      t.string :payment_status
      t.string :payment_type
      t.decimal :payment_fee, :precision => 8, :scale => 2
      t.decimal :payment_gross, :precision => 8, :scale => 2
      t.datetime :payment_date
      t.string :mc_currency
      t.decimal :mc_fee, :precision => 8, :scale => 2
      t.decimal :mc_gross, :precision => 8, :scale => 2
      t.decimal :tax, :precision => 8, :scale => 2
      t.decimal :shipping, :precision => 8, :scale => 2
      t.string :verify_sign

      t.timestamps
    end
  end
end
