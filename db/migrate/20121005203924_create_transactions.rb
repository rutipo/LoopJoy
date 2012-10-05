class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.string :name
      t.string :address
      t.string :email
      t.string :token
      t.decimal :subtotal, :precision => 8, :scale => 2
      t.decimal :shipping, :precision => 8, :scale => 2
      t.decimal :total, :precision => 8, :scale => 2
      t.string :pp_transaction_id
      t.string :lj_transaction_id


      t.timestamps
    end
  end
end
