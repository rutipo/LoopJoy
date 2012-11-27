class PaypalExpressController < ApplicationController

  def checkout
  	item = Item.find(params[:item_id])

    total_as_cents, setup_purchase_params = get_setup_purchase_params item, request
    response = EXPRESS_GATEWAY.setup_purchase(total_as_cents, setup_purchase_params)

    render :json => {
      purchase_params: setup_purchase_params, 
      redirect_url: EXPRESS_GATEWAY.redirect_url_for(response.token),
      token: response.token
    }
  end

  def review
    item = Item.find(params[:item_id])
    
    response = EXPRESS_GATEWAY.details_for(params[:token])
	  order_info = get_order_info gateway_response, item, request

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
    item = Item.find(params[:item_id])

    if params[:token].nil? or params[:payer_id].nil?
	  render json: {
	  	success: "NO", 
	  	message: "There was a problem with your order. \n Please try again later."
	  }
      return
    end

    total_as_cents, purchase_params = get_purchase_params item, request, params
    purchase = EXPRESS_GATEWAY.purchase(total_as_cents, purchase_params)

    transaction = Transaction.where(token: params[:token]).first
    transaction.lj_transaction_id = rand(36**8).to_s(36)
    transaction.pp_transaction_id = params[:transaction_id]
    transaction.save

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
