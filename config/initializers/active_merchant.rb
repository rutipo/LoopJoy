config.after_initialize do
  ActiveMerchant::Billing::Base.mode = :test
  paypal_options = {
    login: "tennys_1348429189_biz_api1.loopjoy.com",
    password: "1348429211",
    signature: "Afv-hdm-OvWEHpiQbbPBRPrylIfPAA5Mi2SORDMzpdD5NZPxZcIbBdL6"
  }
  ::EXPRESS_GATEWAY_BETA = ActiveMerchant::Billing::PaypalExpressGateway.new(paypal_options)

  ActiveMerchant::Billing::Base.mode = :production
  paypal_options = {
    login: "ruti_api1.loopjoy.com",
    password: "79H2HV73GBATM825",
    signature: "AcJ-x2rzE.wiDyTVecBkpKGcrZ2hAL73WtadveBxvFjZUSOzTvLUWs0B"
  }
  ::EXPRESS_GATEWAY_LIVE = ActiveMerchant::Billing::PaypalExpressGateway.new(paypal_options)
end
