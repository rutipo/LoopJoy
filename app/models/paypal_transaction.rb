class PaypalTransaction < ActiveRecord::Base

	require 'net/http'
	require 'net/https'
	require 'uri'

	def initialize(params, raw_post)
    	@params = params
    	@raw = raw_post
  	end

	def valid?
		logger.debug "here"
		logger.debug @params.inspect
		uri = URI.parse("https://www.sandbox.paypal.com/cgi-bin/webscr?cmd=_notify-validate")
		http = Net::HTTP.new(uri.host, uri.port)
		http.open_timeout = 60
		http.read_timeout = 60
		http.use_ssl = true
		http.verify_mode = OpenSSL::SSL::VERIFY_NONE
		

		response = http.post(uri.request_uri, @raw,
		    	'Content-Length' => "#{@raw.size}",'User-Agent' => "Custom Agent").body
		raise StandardError.new("Fault paypal result: #{response}") unless ["VERIFIED","INVALID"].include?(response)
		raise StandardError.new("Invalid IPN: #{response}") unless response == "VERIFIED"
		return true
	end

end
