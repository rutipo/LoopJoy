class PaypalIpnController < ApplicationController

	def ipn
		ppt = PaypalTransaction.new(params,request.body.read)
		if ppt.valid?
			logger.debug("Is Valid")
		else
			logger.debug("Is Not Valid")
		end
	end
end
