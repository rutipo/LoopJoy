class PaypalExpressController < ApplicationController
  include PaypalExpress

  def checkout
  	item = Item.find(params[:item_id])
    gateway = params[:env_type] == "LJ_ENV_SANDBOX" ? EXPRESS_GATEWAY_SANDBOX : EXPRESS_GATEWAY_LIVE

    total_as_cents, setup_purchase_params = get_setup_purchase_params item, request
    response = gateway.setup_purchase(total_as_cents, setup_purchase_params)

    $redis.hmset(response.token.to_s,"env_type",params[:env_type],"item_id",params[:item_id])
    $redis.expire(response.token, 300)

    render :json => {
      purchase_params: setup_purchase_params, 
      redirect_url: gateway.redirect_url_for(response.token),
      token: response.token
    }
  end

  def review
    token = params[:token]
    $redis.expire(token, 300)
    item = Item.find($redis.hget(token,"item_id"))
    
    gateway = $redis.hget(token,"env_type") == "LJ_ENV_SANDBOX" ? EXPRESS_GATEWAY_SANDBOX: EXPRESS_GATEWAY_LIVE
    response = gateway.details_for(token)

	  order_info = get_order_info(response, item, request)

    transaction = Transaction.new(
  	  name: order_info[:name], 
      email: order_info[:email], 
      subtotal: @order_info[:subtotal], 
   	  shipping: @order_info[:shipping], 
      total: @order_info[:total], 
      token: @order_info[:gateway_details][:token]
      )
    transaction.save

    render :json => @order_info
  end

  def purchase
    token = params[:token]

    $redis.expire(token, 300)
    env_type = $redis.hget(token,"env_type")
    item = Item.find($redis.hget(token,"item_id"))

    gateway = env_type == "LJ_ENV_SANDBOX" ? EXPRESS_GATEWAY_SANDBOX : EXPRESS_GATEWAY_LIVE

    if token.nil? or params[:payer_id].nil?
	  render json: {
	  	success: "NO", 
	  	message: "There was a problem with your order. \n Please try again later."
	  }
      return
    end

    total_as_cents, purchase_params = get_purchase_params(item, request, params)
    purchase = gateway.purchase(total_as_cents, purchase_params)


    #only store it in the database if it isn't a live purchase
    if env_type != "LJ_ENV_SANDBOX"
      transaction = Transaction.where(token: params[:token]).first
      transaction.lj_transaction_id = rand(36**8).to_s(36)
      transaction.pp_transaction_id = params[:transaction_id]
      transaction.save
    end

    #send the email regardless
    TransactionMailer.purchase_confirmation(@transaction).deliver
    
    if purchase.success?
      render :json => {
      	success: "YES", 
      	message: "Thank You. \n Your confirmation number is #{transaction.lj_transaction_id}. 
      			 \n You will receive an email shortly."
      	}
    else
      render :json => {
      	success: "NO",
      	message: "There was a problem with your order. \n Please try again later."
      }
    end
  end

end
