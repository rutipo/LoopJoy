module PaypalExpress

  def get_setup_purchase_params(item, request)
    if request.location == nil
      location = "NA"
    else
      location = request.location.country_code
    end

    subtotal, shipping, total = get_totals(item, location)
   
    #return final price and hash of params used for checkout

    return to_cents(total),{
      ip: request.remote_ip,
      return_url: url_for("#{::Lj::Application.config.env_vars.paypal_return_url}"),
      cancel_return_url: url_for("#{::Lj::Application.config.env_vars.paypal_cancel_return_url}"),
      subtotal: to_cents(subtotal),
      shipping: to_cents(shipping),
      handling:  0,
      tax: 0,
      allow_note: true,
      items: [{name: item.name, number: item.id, quantity: '1', amount: to_cents(item.price)}]
    }
  end

  def get_purchase_params(item, request, params)
    if request.location == nil
      location = "NA"
    else
      location = request.location.country_code
    end
    subtotal, shipping, total = get_totals(item,location)
    return to_cents(total), {
      :ip => request.remote_ip,
      :token => params[:token],
      :payer_id => params[:payer_id],
      :subtotal => to_cents(subtotal),
      :shipping => to_cents(shipping),
      :handling => 0,
      :tax =>      0,
      :items =>    [{:name => item.name, :number => item.id, :quantity => '1', :amount => to_cents(item.price)}]
    }
  end

  def get_order_info(gateway_response, item, request)
      subtotal, shipping, total = get_totals(item, request)
      {
        shipping_address: gateway_response.address,
        email: gateway_response.email,
        name: gateway_response.name,
        gateway_details: {
          token: gateway_response.token,
          payer_id: gateway_response.payer_id
        },
        subtotal: ActionController::Base.helpers.number_to_currency(subtotal),
        shipping: ActionController::Base.helpers.number_to_currency(shipping),
        total: ActionController::Base.helpers.number_to_currency(total)
      }
  end

  def get_totals(item, location)
    subtotal = item.price
    shipping = get_shipping(location)
    total = subtotal + shipping

    return subtotal, shipping, total
  end

  def get_shipping(location)
	 return location == "US" ? 2 : 7
  end

  def to_cents(money)
    return (money*100)
  end
end
