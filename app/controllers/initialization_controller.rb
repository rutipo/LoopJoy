class InitializationController < ApplicationController

	def ios_init
		@developer = Developer.where(api_key: params[:api_key]).first
		@items = @developer.items
		render :json => {merchantName: @developer.merchant_name, items: @items}
	end

end