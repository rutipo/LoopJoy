class PaypalWebExpressController < ApplicationController
  include PaypalExpress

  def checkout
  	@item = Item.find(params[:id])
  	total_as_cents, setup_purchase_params = get_setup_purchase_params @item, request
    response = EXPRESS_GATEWAY_LIVE.setup_purchase(total_as_cents, setup_purchase_params)

    @redirect_url = EXPRESS_GATEWAY_LIVE.redirect_url_for(response.token)
  end


end