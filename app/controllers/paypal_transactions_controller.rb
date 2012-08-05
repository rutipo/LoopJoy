class PaypalTransactionsController < ApplicationController

  def index
    @paypal_transactions = PaypalTransaction.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @paypal_transactions }
    end
  end

  def show
    @paypal_transaction = PaypalTransaction.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @paypal_transaction }
    end
  end

  def ipn
    @ppt = PaypalTransaction.new(params[:paypal_transaction])
    if @ppt.paypal_validity?(request.body.read)
      @ppt.save
      logger.debug("Saved Sucessfully")
      TransactionMailer.purchase_notification(@ppt).deliver
      #logic to send an email here
      
    else
      logger.debug("Is Not Valid")
    end
  end
end



#Original scaffolding 

  # def new
  #   @paypal_transaction = PaypalTransaction.new

  #   respond_to do |format|
  #     format.html # new.html.erb
  #     format.json { render :json => @paypal_transaction }
  #   end
  # end

  # def edit
  #   @paypal_transaction = PaypalTransaction.find(params[:id])
  # end


  # def create
  #   @paypal_transaction = PaypalTransaction.new(params[:paypal_transaction])

  #   respond_to do |format|
  #     if @paypal_transaction.save
  #       format.html { redirect_to @paypal_transaction, :notice => 'Paypal transaction was successfully created.' }
  #       format.json { render :json => @paypal_transaction, :status => :created, :location => @paypal_transaction }
  #     else
  #       format.html { render :action => "new" }
  #       format.json { render :json => @paypal_transaction.errors, :status => :unprocessable_entity }
  #     end
  #   end
  # end

  # def update
  #   @paypal_transaction = PaypalTransaction.find(params[:id])

  #   respond_to do |format|
  #     if @paypal_transaction.update_attributes(params[:paypal_transaction])
  #       format.html { redirect_to @paypal_transaction, :notice => 'Paypal transaction was successfully updated.' }
  #       format.json { head :ok }
  #     else
  #       format.html { render :action => "edit" }
  #       format.json { render :json => @paypal_transaction.errors, :status => :unprocessable_entity }
  #     end
  #   end
  # end

  # def destroy
  #   @paypal_transaction = PaypalTransaction.find(params[:id])
  #   @paypal_transaction.destroy

  #   respond_to do |format|
  #     format.html { redirect_to paypal_transactions_url }
  #     format.json { head :ok }
  #   end
  # end

