class Transaction < ActiveRecord::Base
	attr_accessible :name, :address, :email, :token, :subtotal, :shipping, :total, :pp_transaction_id, :lj_transaction_id
end
