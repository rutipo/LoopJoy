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
  	token = params[:token]
  	response = EXPRESS_GATEWAY_LIVE.details_for(token)
  	@item = Item.find($redis.hget(token,"item_id"))


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


end