module PaypalExpressHelper
  include ActionView::Helpers::NumberHelper

  def get_setup_purchase_params(item, request)
  	location = request.location.country_code
    logger.debug(location.inspect)
    subtotal, shipping, total = get_totals(item, location)
   
    #return final price and hash of params used for checkout

    return to_cents(total),{
      :ip => request.remote_ip,
      :return_url => url_for("http://localhost:3000/paypal/success"),
      :cancel_return_url => url_for("http://localhost:3000/paypal/cancel"),
      :subtotal => to_cents(subtotal),
      :shipping => to_cents(shipping),
      :handling => 0,
      :tax =>      0,
      :allow_note =>  true,
      :items => [{:name => item.name, :number => item.id, :quantity => '1', :amount => to_cents(item.price)}],
    }
  end

    def get_order_info(gateway_response, item, request)
      subtotal, shipping, total = get_totals(item, request)
      {
        shipping_address: gateway_response.address,
        email: gateway_response.email,
        name: gateway_response.name,
        gateway_details: {
          :token => gateway_response.token,
          :payer_id => gateway_response.payer_id,
        },
        subtotal: number_to_currency(subtotal),
        shipping: number_to_currency(shipping),
        total: number_to_currency(total),
      }
  end

  # define your own shipping rule based on your cart here
  # this method should return an integer
  def get_shipping(location)

	return location == "US" ? 7 : 12
  end

  def get_totals(item, location)
    subtotal = item.price
    shipping = get_shipping(location)
    total = subtotal + shipping

    return subtotal, shipping, total
  end

  def to_cents(money)
    return (money*100)
    logger.debug(money.inspect)
  end


  # def get_items(cart)
  #   cart.line_items.collect do |line_item|
  #     product = line_item.product

  #     {
  #       :name => product.title, 
  #       :number => product.serial_number, 
  #       :quantity => line_item.quantity, 
  #       :amount => to_cents(product.price), 
  #     }
  #   end
  # end
end
