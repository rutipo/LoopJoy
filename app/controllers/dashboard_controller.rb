class DashboardController < ApplicationController
	before_filter :authenticate_user!

	def current_offerings
		@items = Item.where(:user_id => current_user.id)
	end

	def new_products
		@item = Item.new
	end

	def summary
	end

	def payouts
	end

	def transactions
	end

	def conversions
	end

	def documentation
	end

	def unlockables
	end

	def api_key
	end

end
