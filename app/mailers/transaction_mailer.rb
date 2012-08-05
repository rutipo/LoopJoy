class TransactionMailer < ActionMailer::Base
  default :from => "purchases@loopjoy.com"

  def purchase_confirmation(paypal_transaction)
  	@paypal_transaction = paypal_transaction
  	mail(:to => "#{paypal_transaction.first_name} #{paypal_transaction.last_name} <#{paypal_transaction.user_email}>", :subject => "Thank You for your Purchase")
  end

  def purchase_notification(paypal_transaction)
  	@paypal_transaction = paypal_transaction
  	mail(:to => "ruti@loopjoy.com", :subject => "Transaction #{paypal_transaction.txn_id}")
  end
end
