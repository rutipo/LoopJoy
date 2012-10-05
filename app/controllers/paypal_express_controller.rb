class PaypalExpressController < ApplicationController
  before_filter :assigns_gateway

  include ActiveMerchant::Billing
  include PaypalExpressHelper


  def checkout

  	@item = Item.find(params[:item_id])

    total_as_cents, setup_purchase_params = get_setup_purchase_params @item, request
    setup_response = @gateway.setup_purchase(total_as_cents, setup_purchase_params)

    render :json => {:setup_response => setup_response, :purchase_params => setup_purchase_params, :redirect_url => @gateway.redirect_url_for(setup_response.token), :token => setup_response.token}
  end


  def review
    @item = Item.find(params[:item_id])
    gateway_response = @gateway.details_for(params[:token])

    @order_info = get_order_info gateway_response, @item, request

    @transaction = Transaction.new(:name => params[:shipping_address][:name], :email => params[:email], :subtotal => params[:subtotal], :shipping => params[:shipping], :total => params[:total], :token => params[:gateway_details][:token])
    logger.debug(@order_info.inspect)
    render :json => @order_info
  end

  def purchase

    @item = Item.find(params[:item_id])
    if params[:token].nil? or params[:payer_id].nil?
      #redirect_to home_url, :notice => "Sorry! Something went wrong with the Paypal purchase. Please try again later." 
      #render json error message
      return
    end

    total_as_cents, purchase_params = get_purchase_params @item, request, params
    purchase = @gateway.purchase total_as_cents, purchase_params

    @transaction = Transaction.where(:token => params[:token])
    @transaction.lj_transaction_id = rand(36**8).to_s(36)
    @transaction.pp_transaction_id = params[:transaction_id]
    @transaction.save

    TransactionMailer.purchase_notification(@transaction).deliver

    if purchase.success?
      render :json => {:success => "YES", :message => "Thank You. \n Your order has been confirmed. \n You will receive an email shortly."}
      #you might want to destroy your cart here if you have a shopping cart 
      #notice = "Thanks! Your purchase is now complete!"
      #render successful purchse
    else
      render :json => {:success => "NO", :message => "There was a problem with your order. \n Please try again later."}
      #render unsuccessful purchase
    end

  end


  private
    def assigns_gateway
      # @gateway ||= PaypalExpressGateway.new(
      #   :login => "ruti_api1.loopjoy.com",
      #   :password => "79H2HV73GBATM825",
      #   :signature => "AcJ-x2rzE.wiDyTVecBkpKGcrZ2hAL73WtadveBxvFjZUSOzTvLUWs0B"
      # )
      @gateway ||= PaypalExpressGateway.new(
        :login => "tennys_1348429189_biz_api1.loopjoy.com",
        :password => "1348429211",
        :signature => "Afv-hdm-OvWEHpiQbbPBRPrylIfPAA5Mi2SORDMzpdD5NZPxZcIbBdL6"
      )
    end
end