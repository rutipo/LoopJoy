class PaypalWebExpressController < ApplicationController
  include PaypalExpress

  def checkout
  	@item = Item.find(params[:id])

  	total_as_cents, setup_purchase_params = get_setup_purchase_params @item, request
    response = EXPRESS_GATEWAY_LIVE.setup_purchase(total_as_cents, setup_purchase_params)
    $redis.hmset(response.token.to_s,"item_id",params[:id])
    $redis.expire(response.token, 300)
    @redirect_url = EXPRESS_GATEWAY_LIVE.redirect_url_for(response.token)
  end

  def review
  	@token = params[:token]
  	response = EXPRESS_GATEWAY_LIVE.details_for(@token)
  	@item = Item.find($redis.hget(@token,"item_id"))


  	@order_info = get_order_info(response, @item, request)
  	logger.debug(@order_info.inspect)

    @transaction = Transaction.new(
  	  name: @order_info[:name], 
      email: @order_info[:email], 
      subtotal: @order_info[:subtotal], 
   	  shipping: @order_info[:shipping], 
      total: @order_info[:total], 
      token: @order_info[:gateway_details][:token]
      )
    @transaction.save

  end

  def confirm
    @token = params[:token]

    $redis.expire(@token, 300)
    item = Item.find($redis.hget(@token,"item_id"))

    gateway = EXPRESS_GATEWAY_LIVE

    if @token.nil? or params[:payer_id].nil?
	  	@message = "There was a problem with your order. \n Please try again later."
    end

    total_as_cents, purchase_params = get_purchase_params(item, request, params)
    purchase = gateway.purchase(total_as_cents, purchase_params)


    @transaction = Transaction.where(token: params[:token]).first
    @transaction.lj_transaction_id = rand(36**8).to_s(36)
    @transaction.pp_transaction_id = params[:transaction_id]

    #only store it in the database if it isn't a live purchase                                                                                 
    @transaction.save

    #send the email regardless                                                                                                                 
    TransactionMailer.purchase_confirmation(@transaction).deliver

    if purchase.success?
        @message = "Thank You. \n Your confirmation number is #{@transaction.lj_transaction_id}.                                                 
                         \n You will receive an email shortly."
    else
    	@message = "There was a problem with your order. \n Please try again later."
    end
  end



end