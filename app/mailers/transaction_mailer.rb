class TransactionMailer < ActionMailer::Base
  default :from => "purchases@loopjoy.com"

  def purchase_confirmation(transaction)
  	@transaction = transaction
  	mail(:to => "#{transaction.name} <#{transaction.email}>", :subject => "Your Order Confirmation from LoopJoy")
  end

  def purchase_notification(paypal_transaction)
  	@paypal_transaction = paypal_transaction
  	mail(:to => "ruti@loopjoy.com", :subject => "Transaction #{paypal_transaction.txn_id}")
  end

end
